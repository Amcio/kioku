import 'package:drift/drift.dart';

import 'decks.dart';

class Flashcards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get deckId => integer().references(Decks, #id)();
  TextColumn get front => text()();
  TextColumn get back => text()();

  // Null for new cards
  DateTimeColumn get nextReviewDate => dateTime().nullable()(); // due
  DateTimeColumn get lastReviewDate => dateTime().nullable()(); // lastReview
  IntColumn get state => integer()(); // Learning, Relearning, Review
  IntColumn get step => integer()
      .nullable()(); // step of (learning, relearning, null if in review)
  RealColumn get stability => real().nullable()();
  RealColumn get difficulty => real().nullable()();
}
