import 'package:flutter/material.dart';

import '../ui/deckview.dart';
import '../ui/quests.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
// Add QuestsTab to views
    final List<Widget> _views = [
    const DeckView(),
    const QuestsTab(), 
    const Placeholder() // Settings
  ];
  
  // Add NavigationDestination
  final List<NavigationDestination> destinations = [
    const NavigationDestination(icon: Icon(Icons.view_list), label: 'Decks'),
    const NavigationDestination(icon: Icon(Icons.star), label: 'Quests'),
    const NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
