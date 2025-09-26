import 'package:todo_list_app/src/core/network/api_client.dart';
import '../models/task_model.dart';

// menyambung dari api_client yang sudah dibuat tadi
abstract class TaskDataSources {
  // dibuat sebagai interface/template supaya implementasinya mengikuti aturan yang sama
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> updateTask(int id, TaskModel task);
  Future<void> deleteTask(int id);
}

class TaskDataSourcesImpl implements TaskDataSources {
  final ApiClient apiClient;

  // bedanya TaskDataSources (abstract) diatas sama yang ini, kalau yang TaskDataSourcesImpl ini implementasinya (login pengiriman ke sumber data / API)
  TaskDataSourcesImpl({required this.apiClient});

  @override
  Future<List<TaskModel>> getTasks() async {
    final data = await apiClient.request(
      endpoint: '/todos',
      method: 'GET',
    ); // karena data yang diambil dari api itu bentuknya json, maka kita harus mengubahnya dulu ke bentuk List<Map<String, dynamic>> supaya bisa diolah
    final List decoded = data as List;
    return decoded
        .map((json) => TaskModel.fromJson(json))
        .toList(); // mapping dari json ke TaskModel
  }

  // selebihnya sama mengikuti kaya yang getTasks diatas, tinggal disesuaikan sama endpoint, method, sama teknis penulisannya.
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
