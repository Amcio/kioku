import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:provider/provider.dart';

import '../adapter/fsrs_adapter.dart';
import '../data/database.dart';
import '../data/deck_provider.dart';
import '../data/quest_provider.dart';

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
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack)
          ..addStatusListener((status) {
            _status = status;
          });
  }

  Future<void> _loadSession() async {
    final cards =
        await context.read<DeckProvider>().getSessionCards(widget.deckID);
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

  String _getNextInterval(Flashcard card, fsrs.Rating rating) {
    try {
      final fsrsCard = card.toFsrsCard();
      final scheduler = fsrs.Scheduler();
      final schedulingInfo = scheduler.reviewCard(fsrsCard, rating);
      final nextDue = schedulingInfo.card.due;
      final diff = nextDue.difference(DateTime.now());

      if (diff.inSeconds < 60) return "<1m";
      if (diff.inMinutes < 60) return "${diff.inMinutes}m";
      if (diff.inHours < 24) return "${diff.inHours}h";
      if (diff.inDays < 30) return "${diff.inDays}d";
      if (diff.inDays < 365) return "${(diff.inDays / 30).floor()}mo";
      return "${(diff.inDays / 365).floor()}y";
    } catch (e) {
      return "-";
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
                  ? Text(
                      activeCard.front,
                      style: const TextStyle(fontSize: 24),
                    )
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

  Widget _buildBtn(
    String text,
    Color color,
    fsrs.Rating rating,
    Flashcard card,
  ) {
    final interval = _getNextInterval(card, rating);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onPressed: () {
        // FIX: Check lastReviewDate instead of state to find "New" cards
        if (card.lastReviewDate == null) {
          context.read<QuestProvider>().incrementLearnedCards();
        }

        context.read<DeckProvider>().processReview(card, rating);
        _nextCard();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(
            interval,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
          ),
        ],
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
          title: Text("Card ${_currentIndex + 1}/${_sessionCards.length}")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) =>
                    animatedCard(context, _sessionCards),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildBtn("Again", Colors.red, fsrs.Rating.again, activeCard),
                  ),
                  const SizedBox(width: 8), // Add spacing between buttons
                  Expanded(
                    child: _buildBtn("Hard", Colors.orange, fsrs.Rating.hard, activeCard),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildBtn("Good", Colors.blue, fsrs.Rating.good, activeCard),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildBtn("Easy", Colors.green, fsrs.Rating.easy, activeCard),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}