import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/database.dart';
import 'data/deck_provider.dart';
import 'ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // makes sure plugins are initialized
  final database = AppDatabase();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DeckProvider(database: database),
      child: const FlashcardsApp(),
    ),
  );
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
