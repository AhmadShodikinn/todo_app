import '../repositories/task_repository_domain.dart';

// sesuai nama folder, digunakan sebagai logika use case untuk penghapusan task
class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<void> call(int id) async {
    await repository.deleteTask(id);
  }
}
