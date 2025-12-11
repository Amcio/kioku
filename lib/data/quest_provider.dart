import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class QuestProvider extends ChangeNotifier {
  final AppDatabase database;
  UserProgressData? _data;

  UserProgressData? get data => _data;

  QuestProvider({required this.database}) {
    _init();
  }

  Future<void> _init() async {
    // Watch for changes so the UI updates automatically
    database.watchUserProgress().listen((data) async {
      if (data == null) {
        // Initialize row if it doesn't exist
        await database.into(database.userProgress).insert(
              UserProgressCompanion.insert(
                lastResetDate: Value(DateTime.now()),
                loginQuestDone: const Value(true), // Mark login done immediately
              ),
            );
      } else {
        _data = data;
        _checkDailyReset(data);
        notifyListeners();
      }
    });
  }

  Future<void> _checkDailyReset(UserProgressData data) async {
    final now = DateTime.now();
    final last = data.lastResetDate;

    // Check if we need to reset (if last reset was yesterday or earlier)
    bool needsReset = last == null ||
        last.year != now.year ||
        last.month != now.month ||
        last.day != now.day;

    if (needsReset) {
      await database.update(database.userProgress).write(
            UserProgressCompanion(
              lastResetDate: Value(now),
              loginQuestDone: const Value(true), // Auto-complete login
              loginQuestClaimed: const Value(false),
              learnQuestDone: const Value(false),
              learnQuestClaimed: const Value(false),
              reviewQuestDone: const Value(false),
              reviewQuestClaimed: const Value(false),
            ),
          );
    } else if (!data.loginQuestDone) {
        // Ensure login quest is marked done if it's the same day but somehow missed
        await database.update(database.userProgress).write(
          const UserProgressCompanion(loginQuestDone: Value(true)),
        );
    }
  }

  Future<void> claimReward(String questType) async {
    if (_data == null) return;

    int newBalance = _data!.currency + 10;
    var update = UserProgressCompanion(currency: Value(newBalance));

    switch (questType) {
      case 'login':
        update = update.copyWith(loginQuestClaimed: const Value(true));
        break;
      case 'learn':
        update = update.copyWith(learnQuestClaimed: const Value(true));
        break;
      case 'review':
        update = update.copyWith(reviewQuestClaimed: const Value(true));
        break;
    }

    await database.update(database.userProgress).write(update);
  }
  
  // Call these later when you implement the Learning/Reviewing logic
  Future<void> completeLearnQuest() async {
     await database.update(database.userProgress).write(
       const UserProgressCompanion(learnQuestDone: Value(true))
     );
  }
  
  Future<void> completeReviewQuest() async {
     await database.update(database.userProgress).write(
       const UserProgressCompanion(reviewQuestDone: Value(true))
     );
  }
}