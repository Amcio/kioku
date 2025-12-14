import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;

import '../adapter/fsrs_adapter.dart';
import '../data/database.dart';

class DeckProvider extends ChangeNotifier {
  final AppDatabase database;
  List<Deck> _decks = [];
  List<Flashcard> _cards = [];

  List<Deck> get decks => _decks;
  List<Flashcard> get cards => _cards;

  StreamSubscription<List<Flashcard>>? _cardsSubscription;
  StreamSubscription<List<Deck>>? _decksSubscription;

  DeckProvider(this.database) {
    _initWatcher();
  }

  void _initWatcher() {
    _cardsSubscription = database.watchAllFlashcards().listen((data) {
      _cards = data;
      notifyListeners();
    });
    _decksSubscription = database.watchAllDecks().listen((data) {
      _decks = data;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _cardsSubscription?.cancel();
    _decksSubscription?.cancel();
    super.dispose();
  }

  Future<void> addCard(FlashcardsCompanion newCard) async {
    await database.into(database.flashcards).insert(newCard);
  }

  Future<void> addCardFromString(
    int deckId,
    String front, [
    String back = '',
  ]) async {
    // FIX: Use State 1 (Learning) to avoid "Invalid state value: 0" error.
    // We set 'nextReviewDate' to NOW so it appears immediately in the due queue.
    final companion = FlashcardsCompanion.insert(
      deckId: deckId,
      front: front,
      back: back,
      state: 1, // fsrs.State.learning
      nextReviewDate: Value(DateTime.now()),
    );
    await addCard(companion);
  }

  Future<void> deleteCard(int id) async {
    await (database.delete(database.flashcards)..where((f) => f.id.equals(id))).go();
  }

  Future<void> createDeck(String name) async {
    await database.into(database.decks).insert(DecksCompanion.insert(name: name));
  }

  Future<void> processReview(Flashcard dbRow, fsrs.Rating rating) async {
    fsrs.Card fCard = dbRow.toFsrsCard();
    var pair = fsrs.Scheduler().reviewCard(fCard, rating);
    fsrs.Card updatedCard = pair.card;
    fsrs.ReviewLog reviewLog = pair.reviewLog;

    Flashcard updatedDbRow = updatedCard.updateFlashcard(dbRow);
    Review review = reviewLog.toReviewRow(updatedDbRow.id);

    await (database.update(database.flashcards).replace(updatedDbRow));
    await (database.into(database.reviews).insert(review));
  }

  Future<List<Flashcard>> getSessionCards(
    int deckId, {
    int limit = 50, // Total session limit
  }) async {
    final now = DateTime.now();

    // Fetch ALL cards that are due right now (or in the past)
    // This includes "New" cards (which we set to due=now) and Review cards.
    final dueCards =
        await (database.select(database.flashcards)
              ..where((tbl) => tbl.deckId.equals(deckId))
              ..where(
                (tbl) => tbl.nextReviewDate.isSmallerOrEqualValue(now),
              ) // CHECK DUE DATE
              ..orderBy([
                // Prioritize most overdue cards first
                (t) => OrderingTerm(
                  expression: t.nextReviewDate,
                  mode: OrderingMode.asc,
                ),
              ])
              ..limit(limit))
            .get();

    // Shuffle only for the user experience, so they don't guess based on order
    // But we already filtered to ensure everything here IS actually due.
    List<Flashcard> sessionQueue = [...dueCards];
    sessionQueue.shuffle();

    return sessionQueue;
  }
}
