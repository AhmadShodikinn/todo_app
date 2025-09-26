import '../repositories/task_repository_domain.dart';

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTask(id);
  }
}
