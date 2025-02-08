import '../core/database/task_db.dart';
import '../models/task.dart';

class TaskRepository {
  final TaskDatabase _taskDatabase = TaskDatabase();

  Future<void> insertTask(Task task) async {
    await _taskDatabase.insertTask(task);
  }

  Future<List<Task>> getTasks() async {
    return await _taskDatabase.getTasks();
  }

  Future<void> updateTask(Task task) async {
    await _taskDatabase.updateTask(task);
  }

  Future<void> deleteTask(int id) async {
    await _taskDatabase.deleteTask(id);
  }
}
