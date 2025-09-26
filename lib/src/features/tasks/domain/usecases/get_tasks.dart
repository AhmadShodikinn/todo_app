import '../entities/task.dart';
import '../repositories/task_repository_domain.dart';

// sesuai nama folder, digunakan sebagai logika use case untuk pengambilan daftar task
class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
