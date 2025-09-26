import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository_domain.dart';
import '../datasources/task_datasources.dart';
import '../models/task_model.dart';

class TaskRepositoryData implements TaskRepository {
  final TaskDataSources dataSources;

  TaskRepositoryData(this.dataSources);

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
