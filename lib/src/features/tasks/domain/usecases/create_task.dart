import '../entities/task.dart';
import '../repositories/task_repository_domain.dart';

class CreateTask {
  final TaskRepository repository;

  CreateTask(this.repository);

  Future<Task> call(Task task) async {
    return await repository.createTask(task);
  }
}
