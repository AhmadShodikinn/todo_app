import 'package:todo_list_app/src/core/network/api_client.dart';
import '../models/task_model.dart';

abstract class TaskDataSources {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> updateTask(int id, TaskModel task);
  Future<void> deleteTask(int id);
}

class TaskDataSourcesImpl implements TaskDataSources {
  final ApiClient apiClient;        

  TaskDataSourcesImpl({required this.apiClient});

  @override
  Future<List<TaskModel>> getTasks() async {
    final data = await apiClient.request(endpoint: '/todos', method: 'GET');
    final List decoded = data as List;
    return decoded.map((json) => TaskModel.fromJson(json)).toList();
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final data = await apiClient.request(
      endpoint: '/todos',
      method: 'POST',
      body: task.toJson(),
    );
    return TaskModel.fromJson(data);
  }

  @override
  Future<TaskModel> updateTask(int id, TaskModel task) async {
    final data = await apiClient.request(
      endpoint: '/todos/$id',
      method: 'PUT',
      body: task.toJson(),
    );
    return TaskModel.fromJson(data);
  }

  @override
  Future<void> deleteTask(int id) async {
    await apiClient.request(endpoint: '/todos/$id', method: 'DELETE');
  }
}
