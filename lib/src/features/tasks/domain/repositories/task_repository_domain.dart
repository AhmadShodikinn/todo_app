import '../entities/task.dart';

// repository yang ini digunakan sebagai definisi methode/fungsi yang bisa digunakan oleh sistem
abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> createTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(int id);
}
