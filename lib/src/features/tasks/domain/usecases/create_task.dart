import '../entities/task.dart';
import '../repositories/task_repository_domain.dart';

// sesuai nama folder, digunakan sebagai logika use case untuk pembuatan task
class CreateTask {
  final TaskRepository repository;

  CreateTask(
    this.repository,
  ); // memanggil fungsi yang bisa digunakan di domain/repository/repository_domain tadi

  Future<Task> call(Task task) async {
    return await repository.createTask(task);
  }
}
