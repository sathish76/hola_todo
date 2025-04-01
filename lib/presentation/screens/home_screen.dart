import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_todo/data/models/task/task_model.dart';
import 'package:hola_todo/presentation/mobx/tag/tag_store.dart';
import 'package:hola_todo/presentation/mobx/task/tasks_store.dart';
import 'package:hola_todo/presentation/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TasksStore tasksStore;
  late TagStore tagStore;
  GlobalKey fabKey = GlobalKey();

  @override
  void initState() {
    tasksStore = Provider.of<TasksStore>(context, listen: false);
    tasksStore.fetchTasks();
    tagStore = Provider.of<TagStore>(context, listen: false);
    tagStore.fetchTags();
    super.initState();
  }

  Widget _buildTaskItem(TaskModel task) {
    return ListTile(
      title: Text(
        task.name,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              tasksStore.toggleTaskCompletion(task);
            },
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () {
              tasksStore.removeTask(task);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
      appBar: AppBar(
        title: const Text('Hola Todo'),
        backgroundColor: Colors.blueAccent.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Observer(
                builder:
                    (_) => ListView.builder(
                      itemCount: tasksStore.tasks.length,
                      itemBuilder:
                          (context, index) =>
                              _buildTaskItem(tasksStore.tasks[index]),
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: fabKey,
        onPressed: () {
          final renderBox =
              fabKey.currentContext!.findRenderObject() as RenderBox;
          final offset =
              renderBox.localToGlobal(Offset.zero) +
              Offset(renderBox.size.width / 2, renderBox.size.height / 2);
          tasksStore.prepareNewTask();
          context.push(addRoute, extra: offset);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
