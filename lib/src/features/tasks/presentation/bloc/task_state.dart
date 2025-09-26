import '../../domain/entities/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final String? message;

  TaskLoaded(this.tasks, {this.message});
}

class TaskSuccess extends TaskState {
  final List<Task> tasks;
  final String? message;

  TaskSuccess(this.tasks, this.message);
}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

class TaskFailure extends TaskState {
  final List<Task> tasks;
  final String message;

  TaskFailure(this.tasks, this.message);
}
