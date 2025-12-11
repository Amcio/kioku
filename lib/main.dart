import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/database.dart';
import 'data/deck_provider.dart';
import 'data/quest_provider.dart';
import 'ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // makes sure plugins are initialized
  final database = AppDatabase();
  runApp(
  MultiProvider( // Change to MultiProvider
        providers: [
          ChangeNotifierProvider(create: (_) => DeckProvider(database: database)),
          ChangeNotifierProvider(create: (_) => QuestProvider(database: database)),
        ],
        child: const KiokuApp(),
      ),
    );
  }

class KiokuApp extends StatelessWidget {
  const KiokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
