
// ignore_for_file: unused_import

import 'package:drift/drift.dart';
import 'package:hola_todo/data/database/task.dart';
import 'package:hola_todo/data/database/tag.dart';

@DataClassName('TaskTag')
class TaskTags extends Table {
  IntColumn get taskId => integer().customConstraint('REFERENCES tasks(id) ON DELETE CASCADE')();
  IntColumn get tagId => integer().customConstraint('REFERENCES tags(id) ON DELETE CASCADE')();
}
