import 'package:drift/drift.dart';
import 'package:drift/internal/versioned_schema.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:kioku/data/database.steps.dart';
import 'package:path_provider/path_provider.dart';

import 'decks.dart';
import 'flashcard.dart';
import 'review_log.dart';
import 'user_progress.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Flashcards, Decks, Reviews, UserProgress])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

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
    return (select(flashcards)..where((tbl) => tbl.deckId.equals(deckId))).watch();
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

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        // Following the advice from https://drift.simonbinder.eu/Migrations/api/#general-tips
        await customStatement('PRAGMA foreign_keys = OFF');

        await transaction(
          () => VersionedSchema.runMigrationSteps(
            migrator: m,
            from: from,
            to: to,
            steps: _upgrade,
          ),
        );

        if (kDebugMode) {
          final wrongForeignKeys = await customSelect(
            'PRAGMA foreign_key_check',
          ).get();
          assert(wrongForeignKeys.isEmpty, '${wrongForeignKeys.map((e) => e.data)}');
        }

        await customStatement('PRAGMA foreign_keys = ON');
      },
      beforeOpen: (details) async {
        // suggested here: https://drift.simonbinder.eu/Migrations/tests/#verifying-a-database-schema-at-runtime
        // if (kDebugMode) {
        //   await validateDatabaseSchema();
        // }
      },
    );
  }

  static final _upgrade = migrationSteps(
    from1To2: (m, schema) async {
      await m.createTable(schema.userProgress);
    },
  );
}
