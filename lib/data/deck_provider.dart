import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;

import '../adapter/fsrs_adapter.dart';
import '../data/database.dart';

class DeckProvider extends ChangeNotifier {
  // TODO: (Optional) Look into DAOs (Data Access Objects) for Drift to separate database logic further.
  // TODO: (Not Optional) _cards should hold cards for the current deck. NOT ALL CARDS.
  final AppDatabase database;
  // 1. THE DATA (State)
  List<Deck> _decks = [];
  List<Flashcard> _cards = [];
  // Getter to prevent direct modification from outside
  List<Deck> get decks => _decks;
  List<Flashcard> get cards => _cards;

  StreamSubscription<List<Flashcard>>? _cardsSubscription;
  StreamSubscription<List<Deck>>? _decksSubscription;

  DeckProvider({required this.database}) {
    _initWatcher();
  }

  void _initWatcher() {
    _cardsSubscription = database.watchAllFlashcards().listen((
      flashcardDataList,
    ) {
      _cards = flashcardDataList;
      notifyListeners();
    });
    _decksSubscription = database.watchAllDecks().listen((deckDataList) {
      _decks = deckDataList;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _cardsSubscription?.cancel();
    _decksSubscription?.cancel();
    super.dispose();
  }

  // 2. THE LOGIC (Methods)
  Future<void> addCard(FlashcardsCompanion newCard) async {
    await database.into(database.flashcards).insert(newCard);
  }

  Future<void> addCardFromString(
    int deckId,
    String front, [
    String back = '',
    fsrs.State state = fsrs.State.learning, // Default as in fsrs lib
  ]) async {
    // An automatically generated Companion class that omits required values in the constructor (like id) and provides some boilerplate methods.
    // Rest of the fields will be filled in on first review.
    // nextReviewDate is set to now so we can get cards for review by checking WHERE due < now()
    final companion = FlashcardsCompanion.insert(
      deckId: deckId,
      front: front,
      back: back,
      state: state.value,
      nextReviewDate: Value(DateTime.now()),
    );
    await addCard(companion);
  }

  Future<void> deleteCard(int id) async {
    await (database.delete(
      database.flashcards,
    )..where((f) => f.id.equals(id))).go();
  }

  Future<void> createDeck(String name) async {
    await database
        .into(database.decks)
        .insert(DecksCompanion.insert(name: name));
  }

  void getCardsForDeck(int deckId) {
    return;
    // TODO: This should start a subscription like the ones above in this class
    // Maybe rename function?
    /*
      _cardsSubscription = database.watchFlashcardsInDeck(deckId)
      .listen((data) {
        _activeCards = data;
        notifyListeners();
      });
    */
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
}
