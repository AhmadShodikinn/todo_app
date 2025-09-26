import '../entities/task.dart';
import '../repositories/task_repository_domain.dart';

// sesuai nama folder, digunakan sebagai logika use case untuk pembaruan task
class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<Task> call(Task task) async {
    return await repository.updateTask(task);
  }
}
