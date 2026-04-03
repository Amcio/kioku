import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/deck_provider.dart';
import '../data/quest_provider.dart';
import 'study_widgets.dart';

class WriteStudyScreen extends StatefulWidget {
  final int deckId;
  final bool isReversed;

  const WriteStudyScreen({super.key, required this.deckId, this.isReversed = false});

  @override
  State<StatefulWidget> createState() => _WriteStudyScreenState();
}

class _WriteStudyScreenState extends State<WriteStudyScreen> {
  final TextEditingController _textController = TextEditingController();

  List<Flashcard> _sessionCards = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  late int totalCards = 0;

  bool _isAnswerCorrect = false;
  bool _hasGivenUp = false;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _textController.addListener(_checkAnswer);
  }

  Future<void> _loadSession() async {
    final cards = await context.read<DeckProvider>().getDueCardBatch(widget.deckId);
    if (mounted) {
      setState(() {
        _sessionCards = cards;
        _isLoading = false;
        totalCards = cards.length;
      });
    }
  }

  void _checkAnswer() {
    if (_sessionCards.isEmpty || _currentIndex >= _sessionCards.length) return;

    final activeCard = _sessionCards[_currentIndex];
    final correctAnswer = widget.isReversed ? activeCard.front : activeCard.back;

    // Simple case-insensitive check. You can improve this logic if needed.
    if (_textController.text.trim().toLowerCase() ==
        correctAnswer.trim().toLowerCase()) {
      if (!_isAnswerCorrect) {
        setState(() {
          _isAnswerCorrect = true;
        });
      }
    } else {
      if (_isAnswerCorrect) {
        setState(() {
          _isAnswerCorrect = false;
        });
      }
    }
  }

  void _nextCard() {
    if (_currentIndex < totalCards - 1) {
      setState(() {
        _currentIndex++;
        _isAnswerCorrect = false;
        _hasGivenUp = false;
        _textController.clear();
      });
    } else {
      context.read<QuestProvider>().completeReviewQuest();
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context);
      messenger.showSnackBar(const SnackBar(content: Text("Deck Complete!")));
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Write Mode")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_sessionCards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Write Mode")),
        body: const Center(child: Text("No cards to study right now!")),
      );
    }

    if (_currentIndex >= _sessionCards.length) {
      return const SizedBox.shrink();
    }

    final activeCard = _sessionCards[_currentIndex];
    final questionText = widget.isReversed ? activeCard.back : activeCard.front;
    final answerText = widget.isReversed ? activeCard.front : activeCard.back;

    return Scaffold(
      appBar: AppBar(
        title: Text("Card ${_currentIndex + 1}/${_sessionCards.length}"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 6,
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          questionText,
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                        if (_hasGivenUp) ...[
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          const Text(
                            "Correct Answer:",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            answerText,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Type the answer',
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: _isAnswerCorrect
                        ? Colors.green.withOpacity(0.1)
                        : null,
                  ),
                  enabled: !_isAnswerCorrect && !_hasGivenUp,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),

                // Show review buttons if correct or if they gave up, otherwise show Give Up
                if (_isAnswerCorrect || _hasGivenUp)
                  createReviewOpinionButtons(activeCard, (fsrs.Rating rating) {
                    var now = DateTime.now().toUtc();
                    if (activeCard.lastReviewDate == null ||
                        activeCard.lastReviewDate!.compareTo(
                              DateTime(now.year, now.month, now.day),
                            ) ==
                            -1) {
                      context.read<QuestProvider>().incrementLearnedCards();
                    }

                    context.read<DeckProvider>().processReview(activeCard, rating);
                    _nextCard();
                  })
                else
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasGivenUp = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text("Give Up"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
