import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/deck_provider.dart';
import '../data/quest_provider.dart';
import 'study_widgets.dart';

class StudyScreen extends StatefulWidget {
  final int deckID;

  const StudyScreen({super.key, required this.deckID});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  List<Flashcard> _sessionCards = [];
  bool _isLoading = true;
  int _currentIndex = 0;
  late int totalCards = 0;

  @override
  void initState() {
    super.initState();
    _loadSession();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack)
      ..addStatusListener((status) {
        _status = status;
      });
  }

  Future<void> _loadSession() async {
    final cards = await context.read<DeckProvider>().getDueCardBatch(widget.deckID);
    if (mounted) {
      setState(() {
        _sessionCards = cards;
        _isLoading = false;
        totalCards = cards.length;
      });
    }
  }

  void _flip() {
    if (_status == AnimationStatus.dismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _nextCard() {
    if (_currentIndex < totalCards - 1) {
      setState(() {
        _currentIndex++;
        _controller.reset();
      });
    } else {
      context.read<QuestProvider>().completeReviewQuest();
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context);
      messenger.showSnackBar(const SnackBar(content: Text("Deck Complete!")));
    }
  }

  Widget animatedCard(BuildContext context, List<Flashcard> cards) {
    final activeCard = cards[_currentIndex];
    return GestureDetector(
      onTap: _flip,
      child: Semantics(
        label: 'Flashcard: ${activeCard.front}',
        hint: 'Tap to flip',
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(pi * _animation.value),
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(32),
            child: Container(
              height: 300,
              width: double.infinity,
              alignment: Alignment.center,
              child: _animation.value <= 0.5
                  ? Text(activeCard.front, style: const TextStyle(fontSize: 24))
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: Text(
                        activeCard.back,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Study Mode")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_sessionCards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Study Mode")),
        body: const Center(child: Text("No cards to study right now!")),
      );
    }

    if (_currentIndex >= _sessionCards.length) {
      return const SizedBox.shrink();
    }

    final activeCard = _sessionCards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Card ${_currentIndex + 1}/${_sessionCards.length}"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => animatedCard(context, _sessionCards),
              ),
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}
