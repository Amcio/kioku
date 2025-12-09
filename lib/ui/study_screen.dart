import 'dart:math'; // Required for pi

import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/deck_provider.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen>
    with SingleTickerProviderStateMixin {
  // 1. ANIMATION CONTROLLERS
  late AnimationController _controller;
  late Animation<double> _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  // 2. STATE
  int _currentIndex = 0;
  late int totalCards = 0;

  @override
  void initState() {
    super.initState();
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

  // Toggle the flip
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
        _controller.reset(); // Reset flip to front
      });
    } else {
      // End of Deck
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context);
      messenger.showSnackBar(const SnackBar(content: Text("Deck Complete!")));
    }
  }

  Widget animatedCard(BuildContext context, Widget? child) {
    // TODO: Remove this cards and activeCards reference.
    // It's called again in build(). This should probably be inside the Widgets' state.
    final cards = context.watch<DeckProvider>().cards;
    final activeCard = cards[_currentIndex];
    return GestureDetector(
      onTap: _flip,
      child: Semantics(
        // Accessibility
        label: 'Flashcard: ${activeCard.front}',
        hint: 'Tap to flip',
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(pi * _animation.value), // Rotation
          child: Card(
            elevation: 6,
            margin: const EdgeInsets.all(32),
            child: Container(
              height: 300,
              width: double.infinity,
              alignment: Alignment.center, // Center Text
              // Logic: If rotated more than 89 degrees (0.5), show Back text.
              // We also have to rotate the text 180 degrees so it isn't mirrored.
              child: _animation.value <= 0.5
                  ? Text(
                      activeCard.front,
                      style: const TextStyle(fontSize: 24),
                    ) // Front
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(pi), // Un-mirror back
                      child: Text(
                        activeCard.back,
                        style: const TextStyle(fontSize: 24),
                      ), // Back
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () {
        context.read<DeckProvider>().processReview(card, rating);
        // TODO: Reload the list of cards in this widget.
        // If the user pressed "Hard", a card we jsut reviewed could be next.
        _nextCard();
      },
      child: Text(text), // TODO: Style
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get cards from Provider
    final provider = context.watch<DeckProvider>();
    final cards = provider.cards;
    totalCards = cards.length;

    // Guard against index out of bounds
    if (_currentIndex >= totalCards) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const SizedBox.shrink();
    }

    if (cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Study Mode")),
        body: const Center(child: Text("No cards in this deck!")),
      );
    }

    final activeCard = cards[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Card ${_currentIndex + 1}/$totalCards")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => animatedCard(context, child),
              ),

              // CONTROLS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBtn("Again", Colors.red, fsrs.Rating.again, activeCard),
                  _buildBtn(
                    "Hard",
                    Colors.orange,
                    fsrs.Rating.hard,
                    activeCard,
                  ),
                  _buildBtn("Good", Colors.blue, fsrs.Rating.good, activeCard),
                  _buildBtn("Easy", Colors.green, fsrs.Rating.easy, activeCard),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
