import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository_domain.dart';
import '../datasources/task_datasources.dart';
import '../models/task_model.dart';

// menghubungkan repository dengan data source
// bedanya sama yang data/datasources/task_datasources.dart, kalau yang itu menghubungkan data source dengan api client (mengambil data dari server)
// kalau yang ini digunakan sebagai jembatan penghubung antara data source sama domain (nyediakan data yang sudah diambil dari data source)
class TaskRepositoryData implements TaskRepository {
  final TaskDataSources dataSources;

  TaskRepositoryData(this.dataSources);

  // keempat fungsi dibawah digunakan untuk menerima perintah dari lapisan atas (domain) terus meneruskan perintah tersebut ke data source
  @override
  Future<List<Task>> getTasks() async {
    return await dataSources.getTasks();
  }

  @override
  Future<Task> createTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    final createdTaskModel = await dataSources.createTask(taskModel);
    return createdTaskModel.toEntity();
  }

  @override
  Future<Task> updateTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    final updatedTaskModel = await dataSources.updateTask(task.id, taskModel);
    return updatedTaskModel.toEntity();
  }

  @override
  Future<void> deleteTask(int id) async {
    await dataSources.deleteTask(id);
  }
}
