import '../../domain/entities/task.dart';

// model yang menghubungkan entity Task dengan data dari API (JSON)
class TaskModel extends Task {
  TaskModel({
    required int userId,
    required int id,
    required String title,
    bool completed = false,
  }) : super(userId: userId, id: id, title: title, completed: completed);

  // fungsi untuk mengubah dari json ke TaskModel dan sebaliknya (dua data berikut merupakan converter)
  // tujuannya mempermudah proses komunikasi antara sistem dan API
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  // mengubah dari TaskModel ke json
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'completed': completed};
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      userId: task.userId,
      id: task.id,
      title: task.title,
      completed: task.completed,
    );
  }

  Task toEntity() {
    return Task(userId: userId, id: id, title: title, completed: completed);
  }
}
