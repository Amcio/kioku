import 'package:flutter/material.dart';
import 'package:fsrs/fsrs.dart' as fsrs;
import '../data/database.dart';
import '../adapter/fsrs_adapter.dart';

Row createReviewOpinionButtons(
  Flashcard activeCard,
  void Function(fsrs.Rating) onPressed,
) {
  // TODO: Get colours from theme
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        child: buildBtn(
          "Again",
          Colors.red,
          fsrs.Rating.again,
          activeCard,
          onPressed,
        ),
      ),
      const SizedBox(width: 8), // Add spacing between buttons
      Expanded(
        child: buildBtn(
          "Hard",
          Colors.orange,
          fsrs.Rating.hard,
          activeCard,
          onPressed,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: buildBtn(
          "Good",
          Colors.blue,
          fsrs.Rating.good,
          activeCard,
          onPressed,
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: buildBtn(
          "Easy",
          Colors.green,
          fsrs.Rating.easy,
          activeCard,
          onPressed,
        ),
      ),
    ],
  );
}

Widget buildBtn(
  String text,
  Color color,
  fsrs.Rating rating,
  Flashcard card,
  void Function(fsrs.Rating) onPressed,
) {
  final interval = getNextCardInterval(card, rating);

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    onPressed: () => onPressed(rating),
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

String getNextCardInterval(Flashcard card, fsrs.Rating rating) {
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
