import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_todo/core/utils/utils.dart';
import 'package:hola_todo/data/models/task/task_model.dart';
import 'package:hola_todo/presentation/mobx/tag/tag_store.dart';
import 'package:hola_todo/presentation/mobx/task/tasks_store.dart';
import 'package:hola_todo/presentation/router.dart';
import 'package:provider/provider.dart';
import 'package:relative_time/relative_time.dart';

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
    tagStore = Provider.of<TagStore>(context, listen: false);
    tasksStore.fetchTasks();
    tagStore.fetchTags();
    super.initState();
  }

  Widget _buildTaskItem(TaskModel task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Dismissible(
        onDismissed: (direction) {
          tasksStore.removeTask(task);
        },
        key: Key(task.id.toString()),
        background: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.delete, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Builder(
            builder: (context) {
              return GestureDetector(
                onTapDown: (details) {
                  final tapPosition = details.globalPosition;
                  tasksStore.startTaskEdit(task);
                  context.push(addRoute, extra: tapPosition);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        task.description != null
                            ? Text(
                              task.description!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                            : const SizedBox.shrink(),
                        task.tags != null
                            ? Wrap(
                              children:
                                  task.tags!
                                      .map(
                                        (tag) => Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Chip(
                                            labelPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                  vertical: 0,
                                                ),
                                            label: Text(
                                              tag.name,
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTaskGroup(DateTime date, List<TaskModel> tasks) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(formatDateRelative(date)),
        Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return _buildTaskItem(tasks[index]);
            },
          ),
        ),
      ],
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
                      itemCount: tasksStore.tasksGroupedByDueDate.length,
                      itemBuilder:
                          (context, index) => _buildTaskGroup(
                            tasksStore.tasksGroupedByDueDate.keys
                                .toList()[index],
                            tasksStore.tasksGroupedByDueDate.values
                                .toList()[index],
                          ),
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
