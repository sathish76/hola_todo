import 'dart:async';

import 'package:hola_todo/core/utils/utils.dart';
import 'package:hola_todo/data/models/tag/tag.dart';
import 'package:mobx/mobx.dart';
import 'package:hola_todo/data/models/task/task_model.dart';
import 'package:hola_todo/data/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';

part 'tasks_store.g.dart';

@injectable
class TasksStore = _TasksStore with _$TasksStore;

enum TaskEditMode { add, edit }

abstract class _TasksStore with Store {
  final TaskRepository _taskRepository;

  _TasksStore(this._taskRepository);

  @observable
  ObservableList<TaskModel> tasks = ObservableList<TaskModel>();

  StreamSubscription<List<TaskModel>>? subscription;

  @observable
  TaskEditMode editMode = TaskEditMode.add;

  @observable
  TaskModel? taskSelectedForEdit;

  @computed
  String? get dueDateFormatted => taskSelectedForEdit?.dueDate != null ? formatDate(taskSelectedForEdit!.dueDate) : null;

  @action
  Future<void> fetchTasks() async {
    subscription = _taskRepository.getTasks().listen((taskList) {
      tasks = ObservableList.of(taskList);
    });
  }

  @action
  Future<void> addTask(String name, String description,) async {
    await _taskRepository.addTask(taskSelectedForEdit!.copyWith(name: name, description: description));
    prepareNewTask();
  }

  @action
  Future<void> updateTask(TaskModel updatedTask) async {
    await _taskRepository.addTask(updatedTask);
  }

  @action
  Future<void> removeTask(TaskModel task) async {
    await _taskRepository.deleteTask(task);
  }

  @action
  Future<void> toggleTaskCompletion(TaskModel task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await _taskRepository.updateTask(updatedTask);
  }

  @action
  void startTaskEdit(TaskModel task) {
    taskSelectedForEdit = task;
    editMode = TaskEditMode.edit;
  }

  @action
  void cancelTaskEdit() {
    taskSelectedForEdit = null;
    editMode = TaskEditMode.add;
  }

  @action
  void completeTaskEdit() {
    if (taskSelectedForEdit != null) {
      updateTask(taskSelectedForEdit!);
    }
  }

  @action
  void prepareNewTask() {
    editMode = TaskEditMode.add;
    taskSelectedForEdit = TaskModel(
      id: 0,
      name: '',
      description: '',
      dueDate: DateTime.now(),
      isCompleted: false,
    );
  }

  @action
  void setDueDate(DateTime dueDate) {
    taskSelectedForEdit = taskSelectedForEdit!.copyWith(dueDate: dueDate);
  }

  @action
  void toggleTagSelection(List<TagModel> tags) {
    taskSelectedForEdit = taskSelectedForEdit!.copyWith(tags: tags);
  }

  @action
  void removeTagSelection(TagModel tag) {
    taskSelectedForEdit = taskSelectedForEdit!.copyWith(
    tags: taskSelectedForEdit!.tags?.where((t) => t.id != tag.id).toList() ?? [],
  );
  }
}
