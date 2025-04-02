import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_todo/core/utils/theme.dart';
import 'package:hola_todo/core/utils/utils.dart';
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        task.description != null
                            ? Text(
                              task.description!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    task.isCompleted
                                        ? textColor.withOpacity(0.5)
                                        : textColor,
                              ),
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
        const SizedBox(height: 16),
        Text(
          formatDateRelative(date),
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      appBar: AppBar(
        title: const Text(
          'Hola Todo',
          style: TextStyle(color: Color(0xFF37474F)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Observer(
                      builder: (context) {
                        final selectedTags = tasksStore.filterTags;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tagStore.tags.length,
                          itemBuilder: (context, index) {
                            final tag = tagStore.tags[index];
                            final isSelected = selectedTags.contains(tag);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: FilterChip(
                                label: Text(tag.name),
                                deleteIcon: null,
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    tasksStore.setFilterTags([
                                      ...selectedTags,
                                      tag,
                                    ]);
                                  } else {
                                    tasksStore.setFilterTags(
                                      selectedTags
                                          .where((t) => t.id != tag.id)
                                          .toList(),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      tasksStore.toggleSortAscending();
                    },
                    icon: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.date_range,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.import_export,
                          size: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Observer(
                builder: (context) {
                  if (tasksStore.filterTags.isNotEmpty &&
                      tasksStore.filteredTasks.isEmpty) {
                    return const Center(
                      child: Text(
                        'No tasks found with the selected tags',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }
                  if (tasksStore.filteredTasks.isEmpty) {
                    return const Center(
                      child: Text(
                        'Start adding tasks',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: tasksStore.tasksGroupedByDueDate.length,
                    itemBuilder:
                        (context, index) => _buildTaskGroup(
                          tasksStore.tasksGroupedByDueDate.keys.toList()[index],
                          tasksStore.tasksGroupedByDueDate.values
                              .toList()[index],
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: fabKey,
        backgroundColor: Colors.orangeAccent.shade100,
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
