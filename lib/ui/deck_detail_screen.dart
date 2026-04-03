import 'package:flutter/material.dart';
import 'package:kioku/data/study_settings_provider.dart';
import 'package:kioku/ui/write_study_screen.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/deck_provider.dart';
import 'card_editor.dart';
import 'study_screen.dart';

class DeckDetailScreen extends StatefulWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  State<StatefulWidget> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  Stream<List<Flashcard>>? _deckContents;
  late int _deckId;

  @override
  void initState() {
    super.initState();
    // Save the ID so we can check if it changes later
    _deckId = widget.deck.id;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_deckContents == null) {
      final provider = context.read<DeckProvider>();
      _deckContents = provider.watchDeckContents(_deckId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.deck.name)),
      body: StreamBuilder(
        stream: _deckContents,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          final deckCards = snapshot.data ?? [];

          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: Theme.of(context).cardColor,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Study Session"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (deckCards.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            if (context.read<StudySettingsProvider>().writeMode) {
                              return WriteStudyScreen(deckId: widget.deck.id);
                            } else {
                              return StudyScreen(deckID: widget.deck.id);
                            }
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Add some cards first!")),
                      );
                    }
                  },
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: deckCards.isEmpty
                    ? const Center(child: Text("No cards. Tap + to add one."))
                    : ListView.separated(
                        itemCount: deckCards.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final card = deckCards[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            title: Text(
                              card.front,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  card.back,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                const SizedBox(height: 8),
                                _buildStateBadge(card.state),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context.read<DeckProvider>().deleteCard(card.id);
                              },
                            ),
                            onTap: () => _showCardPreview(context, card),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CardEditor(deckId: _deckId)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getScheduledTime(Flashcard card) {
    if (card.nextReviewDate == null) {
      return "Not scheduled (New)";
    }

    final now = DateTime.now();
    final due = card.nextReviewDate!;
    final diff = due.difference(now);

    if (diff.isNegative) {
      return "Ready Now (Overdue)";
    }

    if (diff.inDays >= 365) {
      return "In ${(diff.inDays / 365).toStringAsFixed(1)} years";
    } else if (diff.inDays >= 30) {
      return "In ${(diff.inDays / 30).toStringAsFixed(1)} months";
    } else if (diff.inDays > 0) {
      return "In ${diff.inDays} days";
    } else if (diff.inHours > 0) {
      return "In ${diff.inHours} hours";
    } else {
      return "In ${diff.inMinutes} minutes";
    }
  }

  void _showCardPreview(BuildContext context, Flashcard card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Card Preview"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Front:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(card.front, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text("Back:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(card.back, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Divider(),
            // Clean Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("State:", style: TextStyle(fontWeight: FontWeight.bold)),
                _buildStateBadge(card.state),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Next Review:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  _getScheduledTime(card),
                  style: TextStyle(
                    color:
                        card.nextReviewDate != null &&
                            card.nextReviewDate!.isBefore(DateTime.now())
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget _buildStateBadge(int state) {
    String label;
    Color color;

    switch (state) {
      case 0:
        label = "New";
        color = Colors.blue;
        break;
      case 1:
        label = "Learning";
        color = Colors.orange;
        break;
      case 2:
        label = "Review";
        color = Colors.green;
        break;
      case 3:
        label = "Relearning";
        color = Colors.red;
        break;
      default:
        label = "Unknown";
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
