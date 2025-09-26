import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({required int id, required String title, bool isCompleted = false})
    : super(id: id, title: title, isCompleted: isCompleted);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted};
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
  }

  Task toEntity() {
    return Task(id: id, title: title, isCompleted: isCompleted);
  }
}
