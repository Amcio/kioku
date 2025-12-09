import 'package:drift/drift.dart';
import 'package:fsrs/fsrs.dart' as fsrs; // Avoid confusion with Flutter's Card

import '../data/database.dart';

extension FlashcardToFsrs on Flashcard {
  fsrs.Card toFsrsCard() {
    return fsrs.Card(
      cardId: id,
      state: fsrs.State.fromValue(state),
      step: step,
      stability: stability,
      difficulty: difficulty,
      due: nextReviewDate,
      lastReview: lastReviewDate,
    );
  }
}

extension FsrsToCompanion on fsrs.Card {
  FlashcardsCompanion toFlashcardCompanion(
    int deckId,
    String front,
    String back,
  ) {
    return FlashcardsCompanion.insert(
      deckId: deckId,
      front: front,
      back: back,
      state: state.value,
      step: Value(step),
      stability: Value(stability),
      difficulty: Value(difficulty),
      nextReviewDate: Value(due),
      lastReviewDate: Value(lastReview),
    );
  }

  Flashcard updateFlashcard(Flashcard dbRow) {
    return dbRow.copyWith(
      state: state.value,
      step: Value(step),
      stability: Value(stability),
      difficulty: Value(difficulty),
      nextReviewDate: Value(due),
      lastReviewDate: Value(lastReview),
    );
  }
}

extension ReviewLogToCompanion on fsrs.ReviewLog {
  Review toReviewRow(int cardId) {
    return Review(
      cardId: cardId,
      rating: rating.value,
      reviewDate: reviewDateTime,
    );
  }
}
