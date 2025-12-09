import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/deck_provider.dart';
import '../ui/study_screen.dart';
import 'card_editor.dart';

class DeckView extends StatelessWidget {
  const DeckView({super.key});

  @override
  Widget build(BuildContext context) {
    // 'context.watch' means: "If DeckProvider calls notifyListeners(), rebuild this widget."
    final deckProvider = context.watch<DeckProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Kioku"), backgroundColor: Colors.red),

      // DISPLAY DATA
      body: ListView.builder(
        itemCount: deckProvider.cards.length,
        prototypeItem: ListTile(
          title: Text(""),
          subtitle: Text(""),
        ), // Performance improvement
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(deckProvider.cards[index].front),
            subtitle: Text(deckProvider.cards[index].back),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StudyScreen()),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              // TRIGGER LOGIC
              onPressed: () {
                // We use 'read' for functions because we don't need to listen to changes
                // inside a button press callback.
                context.read<DeckProvider>().deleteCard(
                  deckProvider.cards[index].id,
                );
              },
            ),
          );
        },
      ),

      // ADD NEW DATA
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => CardEditor()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
