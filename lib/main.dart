import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';

import 'data/database.dart';
import 'data/deck_provider.dart';
import 'data/quest_provider.dart';
import 'data/study_settings_provider.dart';
import 'data/theme_provider.dart';
import 'ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // makes sure plugins are initialized
  final database = AppDatabase();
  final oldPrefs = await SharedPreferences.getInstance();
  final SharedPreferencesWithCache prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );

  await migrateLegacySharedPreferencesToSharedPreferencesAsyncIfNecessary(
    legacySharedPreferencesInstance: oldPrefs,
    sharedPreferencesAsyncOptions: const SharedPreferencesOptions(),
    migrationCompletedKey: 'migrationCompleted',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeckProvider(database)),
        ChangeNotifierProvider(create: (_) => QuestProvider(database)),
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider(create: (_) => StudySettingsProvider(prefs)),
      ],
      child: const KiokuApp(),
    ),
  );
}

class KiokuApp extends StatelessWidget {
  const KiokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;
    final accentColour = context.watch<ThemeProvider>().materialColor;
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: ThemeData.light().colorScheme.copyWith(secondary: accentColour),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(secondary: accentColour),
      ),
      themeMode: themeMode,
      home: HomeScreen(),
    );
  }
}
