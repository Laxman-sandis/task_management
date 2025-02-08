import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/models/theme_model.dart';
import 'package:task_management_app/resources/string_helper.dart';
import 'package:task_management_app/viewmodels/theme_viewmodel.dart';

import '../models/task.dart';
import '../viewmodels/task_viewmodel.dart';
import 'add_task_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final theme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.homeScreen, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(theme == AppTheme.light ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          )
        ],
      ),
      body: tasks.isEmpty
          ? _buildEmptyState()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return _buildTaskCard(context, ref, task);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        label: const Text(StringHelper.addTaskTitle),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// Widget to show when there are no tasks
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          Text(
            StringHelper.noTasksAvailable,
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 5),
          Text(
            StringHelper.tapToAddTask,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  /// Card UI for a task item
  Widget _buildTaskCard(BuildContext context, WidgetRef ref, Task task) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen(task: task)),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Status Indicator
              CircleAvatar(
                radius: 24,
                backgroundColor: task.isCompleted ? Colors.green : Colors.orange,
                child: Icon(
                  task.isCompleted ? Icons.check : Icons.pending,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Flexible Task Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            task.dueDate,
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Actions: Checkbox + Edit + Delete
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 4,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    value: task.isCompleted,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      ref.read(taskProvider.notifier).updateTask(
                            Task(
                              id: task.id,
                              title: task.title,
                              description: task.description,
                              dueDate: task.dueDate,
                              isCompleted: val!,
                            ),
                          );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(context, ref, task.id!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Delete Confirmation Dialog
  void _showDeleteDialog(BuildContext context, WidgetRef ref, int taskId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(StringHelper.deleteTask),
          content: const Text(StringHelper.deleteTaskMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(StringHelper.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                ref.read(taskProvider.notifier).deleteTask(taskId);
                Navigator.pop(context);
              },
              child: const Text(StringHelper.delete),
            ),
          ],
        );
      },
    );
  }
}
