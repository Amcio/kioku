import 'dart:math';
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
    database.watchUserProgress().listen((data) async {
      if (data == null) {
        await database.into(database.userProgress).insert(
              UserProgressCompanion.insert(
                lastResetDate: Value(DateTime.now()),
                loginQuestDone: const Value(true),
              ),
            );
      } else {
        _data = data;
        await _checkDailyReset(data);
        await _checkAllDailyComplete();
        notifyListeners();
      }
    });
  }

  Future<void> _checkDailyReset(UserProgressData data) async {
    final now = DateTime.now();
    final last = data.lastResetDate;

    bool needsReset = last == null ||
        last.year != now.year ||
        last.month != now.month ||
        last.day != now.day;

    if (needsReset) {
      await database.update(database.userProgress).write(
            UserProgressCompanion(
              lastResetDate: Value(now),
              loginQuestDone: const Value(true),
              loginQuestClaimed: const Value(false),
              learnQuestDone: const Value(false),
              learnQuestClaimed: const Value(false),
              cardsLearnedToday: const Value(0),
              reviewQuestDone: const Value(false),
              reviewQuestClaimed: const Value(false),
              allDailyQuestsDone: const Value(false),
              allDailyQuestsClaimed: const Value(false),
            ),
          );
    } else if (!data.loginQuestDone) {
      await database.update(database.userProgress).write(
            const UserProgressCompanion(loginQuestDone: Value(true)),
          );
    }
  }

  Future<void> incrementLearnedCards() async {
    if (_data == null) return;
    
    // 1. Increment
    int current = _data!.cardsLearnedToday;
    int next = current + 1;
    
    await database.update(database.userProgress).write(
      UserProgressCompanion(cardsLearnedToday: Value(next)),
    );

    // 2. Check for completion (Target: 5)
    if (next >= 5 && !_data!.learnQuestDone) {
      await completeLearnQuest();
    }
  }
  
  // Check if the 3 main quests are done
  Future<void> _checkAllDailyComplete() async {
    if (_data == null) return; 
    final allDone = _data!.loginQuestDone && 
                    _data!.learnQuestDone && 
                    _data!.reviewQuestDone;

    if (allDone && !_data!.allDailyQuestsDone) {
      await database.update(database.userProgress).write(
        const UserProgressCompanion(allDailyQuestsDone: Value(true)),
      );
    }
  }

  Future<void> claimReward(String questType) async {
    if (_data == null) return;

    int reward = (questType == 'dailyDone') ? 20 : 10;
    int newBalance = _data!.currency + reward;
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
      case 'dailyDone':
        update = update.copyWith(allDailyQuestsClaimed: const Value(true));
        break;
    }

    await database.update(database.userProgress).write(update);
  }

  Future<void> completeLearnQuest() async {
    await database.update(database.userProgress).write(
          const UserProgressCompanion(learnQuestDone: Value(true)),
        );
  }

  Future<void> completeReviewQuest() async {
    await database.update(database.userProgress).write(
          const UserProgressCompanion(reviewQuestDone: Value(true)),
        );
  }

    Future<void> completeAllDailyQuests() async {
    await database.update(database.userProgress).write(
          const UserProgressCompanion(allDailyQuestsDone: Value(true)),
        );
  }

  // --- SHOP / GACHA HELPERS ---

  // Check if there is anything left to unlock
  bool get hasLockedColors {
    if (_data == null) return false;
    // If ANY of these are false, we have locked colors
    return !_data!.unlockedGreen ||
           !_data!.unlockedBlue ||
           !_data!.unlockedYellow ||
           !_data!.unlockedPink ||
           !_data!.unlockedOrange ||
           !_data!.unlockedPurple;
  }

  bool isColorUnlocked(String colorName) {
    if (colorName == 'Red') return true;
    if (_data == null) return false;

    switch (colorName) {
      case 'Green': return _data!.unlockedGreen;
      case 'Blue': return _data!.unlockedBlue;
      case 'Yellow': return _data!.unlockedYellow;
      case 'Pink': return _data!.unlockedPink;
      case 'Orange': return _data!.unlockedOrange;
      case 'Purple': return _data!.unlockedPurple;
      default: return false;
    }
  }

  // Gacha Logic
  Future<String?> unlockRandomColor(int cost) async {
    if (_data == null) return null;
    if (_data!.currency < cost) return null;

    // 1. Identify what is locked
    List<String> lockedColors = [];
    if (!_data!.unlockedGreen) lockedColors.add('Green');
    if (!_data!.unlockedBlue) lockedColors.add('Blue');
    if (!_data!.unlockedYellow) lockedColors.add('Yellow');
    if (!_data!.unlockedPink) lockedColors.add('Pink');
    if (!_data!.unlockedOrange) lockedColors.add('Orange');
    if (!_data!.unlockedPurple) lockedColors.add('Purple');

    if (lockedColors.isEmpty) return 'ALL';

    // 2. Pick Random
    final random = Random();
    final colorToUnlock = lockedColors[random.nextInt(lockedColors.length)];

    // 3. Update DB
    int newBalance = _data!.currency - cost;
    var update = UserProgressCompanion(currency: Value(newBalance));

    switch (colorToUnlock) {
      case 'Green': update = update.copyWith(unlockedGreen: const Value(true)); break;
      case 'Blue': update = update.copyWith(unlockedBlue: const Value(true)); break;
      case 'Yellow': update = update.copyWith(unlockedYellow: const Value(true)); break;
      case 'Pink': update = update.copyWith(unlockedPink: const Value(true)); break;
      case 'Orange': update = update.copyWith(unlockedOrange: const Value(true)); break;
      case 'Purple': update = update.copyWith(unlockedPurple: const Value(true)); break;
    }

    await database.update(database.userProgress).write(update);
    return colorToUnlock;
  }
  
  // Debug Tool
  Future<void> debugAddCurrency(int amount) async {
    if (_data == null) return;
    await database.update(database.userProgress).write(
      UserProgressCompanion(currency: Value(_data!.currency + amount)),
    );
  }
}