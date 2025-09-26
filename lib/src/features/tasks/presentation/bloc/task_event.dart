import '../../domain/entities/task.dart';

// task event digunakan sebagai perintah atau aksi yang mau dilakukan sama pengguna, bedanya sama task_state, kalau state itu keluaran/hasil dari event yang dilakukan

abstract class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent(this.task);
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TaskEvent {
  final int taskId;
  DeleteTaskEvent(this.taskId);
}
