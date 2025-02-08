import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/task_repository.dart';
import '../models/task.dart';

final taskProvider = StateNotifierProvider<TaskViewModel, List<Task>>((ref) => TaskViewModel());

class TaskViewModel extends StateNotifier<List<Task>> {
  final TaskRepository _taskRepo = TaskRepository();

  TaskViewModel() : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await _taskRepo.getTasks();
    state = _sortTasks(tasks);
  }

  Future<void> addTask(Task task) async {
    await _taskRepo.insertTask(task);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _taskRepo.updateTask(task);
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _taskRepo.deleteTask(id);
    loadTasks();
  }

  /// Sorts tasks by due date first, then by priority (High > Medium > Low)
  List<Task> _sortTasks(List<Task> tasks) {
    return [...tasks]
      ..sort((a, b) {
        if (a.dueDate != b.dueDate) {
          return a.dueDate.compareTo(b.dueDate); // Sort by due date
        }
        return b.priority.index.compareTo(a.priority.index); // Then by priority
      });
  }
}
