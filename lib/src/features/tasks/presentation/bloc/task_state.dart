import '../../domain/entities/task.dart';

// daftar state/status yang bisa terjadi di fitur task, misal: loading, loaded, error, dsb

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

// digunakan untuk menampung data task yang sudah diambil
class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final String? message;

  TaskLoaded(this.tasks, {this.message});
}

// state ini digunakan untuk menampilkan proses task berhasil dilakukan
class TaskSuccess extends TaskState {
  final List<Task> tasks;
  final String? message;

  TaskSuccess(this.tasks, this.message);
}

// state ini digunakan untuk menampilkan proses task gagal dilakukan
class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

// state ini digunakan untuk menampilkan proses task gagal dilakukan, tapi masih menyimpan data task sebelumnya
class TaskFailure extends TaskState {
  final List<Task> tasks;
  final String message;

  TaskFailure(this.tasks, this.message);
}
