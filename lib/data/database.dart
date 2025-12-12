import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'flashcard.dart';
import 'decks.dart';
import 'review_log.dart';
import 'user_progress.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Flashcards, Decks, Reviews, UserProgress])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // Add the new table for existing users
          await m.createTable(userProgress);
        }
        if (from < 3) {
          // Add new columns for the shop
          await m.addColumn(userProgress, userProgress.unlockedGreen);
          await m.addColumn(userProgress, userProgress.unlockedBlue);
          await m.addColumn(userProgress, userProgress.unlockedYellow);
          await m.addColumn(userProgress, userProgress.unlockedPink);
          await m.addColumn(userProgress, userProgress.unlockedOrange);
          await m.addColumn(userProgress, userProgress.unlockedPurple);
        }
        if (from < 4) {
          // Add allDailyQuests columns
          await m.addColumn(userProgress, userProgress.allDailyQuestsDone);
          await m.addColumn(userProgress, userProgress.allDailyQuestsClaimed);
        }
        if (from < 5) {
          await m.addColumn(userProgress, userProgress.cardsLearnedToday);
        }
      },
    );
  }

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
  Stream<UserProgressData?> watchUserProgress() {
    return select(userProgress).watchSingleOrNull();
  }

  // DEBUG clear database
  Future<void> clearAllData() async {
    await delete(reviews).go();
    await delete(flashcards).go();
    await delete(decks).go();
    await delete(userProgress).go();
  }
}

