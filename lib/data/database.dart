import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'flashcard.dart';
import 'decks.dart';
import 'review_log.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Flashcards, Decks, Reviews])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'flashcard_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse("sqlite3.wasm"),
        driftWorker: Uri.parse("drift_worker.js"),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Using ${result.chosenImplementation} due to missing: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }

  Stream<List<Flashcard>> watchAllFlashcards() {
    return select(flashcards).watch();
  }

  Stream<List<Flashcard>> watchFlashcardsInDeck(int deckId) {
    return (select(
      flashcards,
    )..where((tbl) => tbl.deckId.equals(deckId))).watch();
  }

  Stream<List<Deck>> watchAllDecks() {
    return select(decks).watch();
  }
}
