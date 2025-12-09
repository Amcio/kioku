import 'package:drift/drift.dart';

class Decks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get cardCount => integer().withDefault(const Constant(0))();
}
