import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_todo/presentation/mobx/tag/tag_store.dart';
import 'package:hola_todo/presentation/mobx/task/tasks_store.dart';
import 'package:provider/provider.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  late TasksStore tasksStore;
  late TagStore tagStore;
  final TextEditingController _taskController = TextEditingController(text: "Buy Eggs");
  final TextEditingController _descriptionController = TextEditingController(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");

  @override
  void initState() {
    tasksStore = Provider.of<TasksStore>(context, listen: false);
    tagStore = Provider.of<TagStore>(context, listen: false);
    super.initState();
  }

  void addTagDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final tagController = TextEditingController();
        return AlertDialog(
          title: Text('Add Tag'),
          content: TextField(
            controller: tagController,
            decoration: InputDecoration(hintText: 'Enter tag name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                tagStore.addTag(tagController.text);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade100,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: Text(
          tasksStore.editMode == TaskEditMode.add ? 'Add Task' : 'Edit Task',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title', style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: 'Buy groceries',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              Text('Description', style: Theme.of(context).textTheme.titleLarge),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Short description of the task',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (context) {
                  return Row(
                    children: [
                      Text(
                        'Due Date:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                tasksStore.taskSelectedForEdit?.dueDate ??
                                DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          selectedDate = selectedDate != null ? DateTime(selectedDate.year, selectedDate.month, selectedDate.day) : null;
                          if (selectedDate != null) {
                            tasksStore.setDueDate(selectedDate);
                          }
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                      Text(
                        tasksStore.dueDateFormatted ?? 'No due date',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              Text('Tags', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'Select tags for the task',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Observer(
                  builder: (context) {
                    return Wrap(
                      children: [
                        ...tagStore.tags.map(
                          (tag) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(tag.name),
                              deleteIcon: null,
                              selected:
                                  tasksStore.taskSelectedForEdit?.tags?.contains(
                                    tag,
                                  ) ??
                                  false,
                              onSelected: (selected) {
                                if (selected) {
                                  tasksStore.toggleTagSelection([
                                    ...tasksStore.taskSelectedForEdit!.tags ?? [],
                                    tag,
                                  ]);
                                } else {
                                  tasksStore.removeTagSelection(tag);
                                }
                              },
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            addTagDialog();
                          },
                          child: Text('Add Tag'),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (tasksStore.editMode == TaskEditMode.add) {
                      tasksStore.addTask(
                        _taskController.text,
                        _descriptionController.text,
                      );
                    } else {
                      tasksStore.updateTask(
                        _taskController.text,
                        _descriptionController.text,
                      );
                    }
                    context.pop();
                  },
                  child: Text(
                    tasksStore.editMode == TaskEditMode.add
                        ? 'Add Task'
                        : 'Update Task',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
