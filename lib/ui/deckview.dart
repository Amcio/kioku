import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart'; 
import '../data/deck_provider.dart';
import 'deck_detail_screen.dart';

class DeckView extends StatelessWidget {
  const DeckView({super.key});

  @override
  Widget build(BuildContext context) {
    final deckProvider = context.watch<DeckProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Decks"), backgroundColor: Colors.red),
      body: deckProvider.decks.isEmpty
          ? const Center(child: Text("No decks yet. Create one!"))
          : ListView.builder(
              itemCount: deckProvider.decks.length,
              itemBuilder: (context, index) {
                final Deck deck = deckProvider.decks[index];
                return ListTile(
                  leading: const Icon(Icons.folder, size: 40, color: Colors.amber),
                  title: Text(deck.name),
                  subtitle: Text("${deckProvider.cards.where((c) => c.deckId == deck.id).length} cards"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeckDetailScreen(deck: deck),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDeckDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDeckDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create New Deck"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Deck Name"),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<DeckProvider>().createDeck(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}