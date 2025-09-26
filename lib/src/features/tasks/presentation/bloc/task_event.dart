import '../../domain/entities/task.dart';

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
