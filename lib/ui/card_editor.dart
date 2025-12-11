import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/deck_provider.dart';

class CardEditor extends StatefulWidget {
  final int deckId;

  const CardEditor({super.key, required this.deckId});

  @override
  State<CardEditor> createState() => _CardEditorState();
}

class _CardEditorState extends State<CardEditor> {
  final _frontController = TextEditingController();
  final _backController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _frontController.dispose();
    _backController.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      final frontText = _frontController.text;
      final backText = _backController.text;

      context.read<DeckProvider>().addCardFromString(widget.deckId, frontText, backText);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Flashcard'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveCard),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _frontController,
                decoration: const InputDecoration(labelText: "Card Front"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text for the front of the card';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _backController,
                decoration: const InputDecoration(labelText: "Card Back"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text for the back of the card';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveCard,
                child: const Text("Save Card"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
