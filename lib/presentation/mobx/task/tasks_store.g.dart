// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TasksStore on _TasksStore, Store {
  Computed<String?>? _$dueDateFormattedComputed;

  @override
  String? get dueDateFormatted => (_$dueDateFormattedComputed ??=
          Computed<String?>(() => super.dueDateFormatted,
              name: '_TasksStore.dueDateFormatted'))
      .value;

  late final _$tasksAtom = Atom(name: '_TasksStore.tasks', context: context);

  @override
  ObservableList<TaskModel> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<TaskModel> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$editModeAtom =
      Atom(name: '_TasksStore.editMode', context: context);

  @override
  TaskEditMode get editMode {
    _$editModeAtom.reportRead();
    return super.editMode;
  }

  @override
  set editMode(TaskEditMode value) {
    _$editModeAtom.reportWrite(value, super.editMode, () {
      super.editMode = value;
    });
  }

  late final _$taskSelectedForEditAtom =
      Atom(name: '_TasksStore.taskSelectedForEdit', context: context);

  @override
  TaskModel? get taskSelectedForEdit {
    _$taskSelectedForEditAtom.reportRead();
    return super.taskSelectedForEdit;
  }

  @override
  set taskSelectedForEdit(TaskModel? value) {
    _$taskSelectedForEditAtom.reportWrite(value, super.taskSelectedForEdit, () {
      super.taskSelectedForEdit = value;
    });
  }

  late final _$fetchTasksAsyncAction =
      AsyncAction('_TasksStore.fetchTasks', context: context);

  @override
  Future<void> fetchTasks() {
    return _$fetchTasksAsyncAction.run(() => super.fetchTasks());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_TasksStore.addTask', context: context);

  @override
  Future<void> addTask(String name, String description) {
    return _$addTaskAsyncAction.run(() => super.addTask(name, description));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('_TasksStore.updateTask', context: context);

  @override
  Future<void> updateTask(TaskModel updatedTask) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(updatedTask));
  }

  late final _$removeTaskAsyncAction =
      AsyncAction('_TasksStore.removeTask', context: context);

  @override
  Future<void> removeTask(TaskModel task) {
    return _$removeTaskAsyncAction.run(() => super.removeTask(task));
  }

  late final _$toggleTaskCompletionAsyncAction =
      AsyncAction('_TasksStore.toggleTaskCompletion', context: context);

  @override
  Future<void> toggleTaskCompletion(TaskModel task) {
    return _$toggleTaskCompletionAsyncAction
        .run(() => super.toggleTaskCompletion(task));
  }

  late final _$_TasksStoreActionController =
      ActionController(name: '_TasksStore', context: context);

  @override
  void startTaskEdit(TaskModel task) {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.startTaskEdit');
    try {
      return super.startTaskEdit(task);
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cancelTaskEdit() {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.cancelTaskEdit');
    try {
      return super.cancelTaskEdit();
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void completeTaskEdit() {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.completeTaskEdit');
    try {
      return super.completeTaskEdit();
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void prepareNewTask() {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.prepareNewTask');
    try {
      return super.prepareNewTask();
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDueDate(DateTime dueDate) {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.setDueDate');
    try {
      return super.setDueDate(dueDate);
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTagSelection(List<TagModel> tags) {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.toggleTagSelection');
    try {
      return super.toggleTagSelection(tags);
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTagSelection(TagModel tag) {
    final _$actionInfo = _$_TasksStoreActionController.startAction(
        name: '_TasksStore.removeTagSelection');
    try {
      return super.removeTagSelection(tag);
    } finally {
      _$_TasksStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasks: ${tasks},
editMode: ${editMode},
taskSelectedForEdit: ${taskSelectedForEdit},
dueDateFormatted: ${dueDateFormatted}
    ''';
  }
}
