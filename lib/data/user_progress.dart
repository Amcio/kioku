import 'package:drift/drift.dart';

class UserProgress extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get currency => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastResetDate => dateTime().nullable()();

  // Quest 1: Log in
  BoolColumn get loginQuestDone => boolean().withDefault(const Constant(false))();
  BoolColumn get loginQuestClaimed => boolean().withDefault(const Constant(false))();

  // Quest 2: Learn 5 words
  BoolColumn get learnQuestDone => boolean().withDefault(const Constant(false))();
  BoolColumn get learnQuestClaimed => boolean().withDefault(const Constant(false))();
  IntColumn get cardsLearnedToday => integer().withDefault(const Constant(0))();

  // Quest 3: Daily Review
  BoolColumn get reviewQuestDone => boolean().withDefault(const Constant(false))();
  BoolColumn get reviewQuestClaimed => boolean().withDefault(const Constant(false))();

    // Quest 3: All Daily Quests
  BoolColumn get allDailyQuestsDone => boolean().withDefault(const Constant(false))();
  BoolColumn get allDailyQuestsClaimed => boolean().withDefault(const Constant(false))();

  // Shop Unlocks
  BoolColumn get unlockedGreen => boolean().withDefault(const Constant(false))();
  BoolColumn get unlockedBlue => boolean().withDefault(const Constant(false))();
  BoolColumn get unlockedYellow => boolean().withDefault(const Constant(false))();
  BoolColumn get unlockedPink => boolean().withDefault(const Constant(false))();
  BoolColumn get unlockedOrange => boolean().withDefault(const Constant(false))();
  BoolColumn get unlockedPurple => boolean().withDefault(const Constant(false))();
}