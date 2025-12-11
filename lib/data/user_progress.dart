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

  // Quest 3: Daily Review
  BoolColumn get reviewQuestDone => boolean().withDefault(const Constant(false))();
  BoolColumn get reviewQuestClaimed => boolean().withDefault(const Constant(false))();
}