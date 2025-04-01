import 'package:drift/drift.dart';
import 'package:hola_todo/data/database/app_database.dart';
import 'package:hola_todo/data/models/task/task_model.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TaskRepository {
  final AppDatabase _database;

  TaskRepository(this._database);

  Stream<List<TaskModel>> getTasks() {
    return (_database.select(_database.tasks).join([
      leftOuterJoin(
        _database.taskTags,
        _database.taskTags.taskId.equalsExp(_database.tasks.id),
      ),
      leftOuterJoin(
        _database.tags,
        _database.tags.id.equalsExp(_database.taskTags.tagId),
      ),
    ])).watch().map((query) {
      final Map<int, TaskModel> taskMap = {};

      for (final row in query) {
        final task = row.readTable(_database.tasks);
        final tag = row.readTableOrNull(_database.tags);

        if (!taskMap.containsKey(task.id)) {
          taskMap[task.id] = TaskModel(
            id: task.id,
            name: task.name,
            dueDate: task.dueDate,
            isCompleted: task.isCompleted,
            tags: [],
          );
        }

        if (tag != null) {
          taskMap[task.id]!.tags!.add(tag);
        }
      }

      return taskMap.values.toList();
    });
  }

  Future<void> addTask(TaskModel task) async {
    await _database.tasks.insertOne(
      TasksCompanion.insert(
        name: task.name,
        dueDate: task.dueDate,
        isCompleted: task.isCompleted,
        description: task.description == null ? const Value(null) : Value(task.description),
      ),
    );
  }

  Future<void> deleteTask(TaskModel task) async {
    await _database.tasks.deleteOne(
      TasksCompanion.insert(
        id: Value(task.id),
        name: task.name,
        dueDate: task.dueDate,
        isCompleted: task.isCompleted,
        description: task.description == null ? const Value(null) : Value(task.description),
      ),
    );
  }

  Future<void> updateTask(TaskModel task) async {
    await _database.tasks.replaceOne(
      TasksCompanion.insert(
        id: Value(task.id),
        name: task.name,
        dueDate: task.dueDate,
        isCompleted: task.isCompleted,
        description: task.description == null ? const Value(null) : Value(task.description),
      ),
    );
  }
}
