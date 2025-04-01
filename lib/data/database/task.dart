import 'package:drift/drift.dart';
import 'package:hola_todo/data/models/task/task_model.dart';

@DataClassName('Task')
@UseRowClass(TaskModel)
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get isCompleted => boolean()();
}
