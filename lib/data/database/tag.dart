import 'package:drift/drift.dart';
import 'package:hola_todo/data/models/tag/tag.dart';

@DataClassName('Tag')
@UseRowClass(TagModel)
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}

