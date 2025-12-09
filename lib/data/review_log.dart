import 'package:drift/drift.dart';

import '../data/flashcard.dart';

class Reviews extends Table {
  IntColumn get cardId => integer().references(Flashcards, #id)();
  IntColumn get rating => integer()();
  DateTimeColumn get reviewDate => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {cardId, reviewDate};
}
