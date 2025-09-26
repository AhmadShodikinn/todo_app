import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';
import 'task_event.dart';
import 'task_state.dart';

// Bloc (Business Logic Component) digunakan untuk mengelola state aplikasi berdasarkan event yang terjadi,
// komunikasinya dimulai dari segi UI (awal)->task event(mau ngapain)->task bloc(diproses logikanya)->task state(status permintaanya tadi apa)->kembali ke UI(akhir)

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    on<LoadTaskEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await getTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    // contoh logika bisnis dari addTask, dia ngecek dulu statenya apa, kalau loaded, dia ambil data task yang ada,
    // terus nambahin task baru, terus emit (ngasi respon) state success, baru emit state loaded lagi
    on<AddTaskEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        try {
          final createdTask = await createTask(event.task);
          final updatedTasks = [createdTask, ...currentState.tasks];
          emit(TaskSuccess(updatedTasks, 'Task added successfully'));
          emit(TaskLoaded(updatedTasks));
        } catch (e) {
          emit(TaskError('Failed to add task: ${e.toString()}'));
          // emit(TaskFailure(currentState.tasks, 'Failed to delete task'));
        }
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;

        try {
          final updatedTask = await updateTask(event.task); // bisa throw
          final updatedTasks = currentState.tasks.map((t) {
            return t.id == updatedTask.id ? updatedTask : t;
          }).toList();
          emit(TaskSuccess(updatedTasks, 'Task updated successfully'));
          emit(TaskLoaded(updatedTasks));
        } catch (e) {
          emit(TaskError('Failed to update task'));

          emit(TaskLoaded(currentState.tasks));
          // emit(TaskFailure(currentState.tasks, 'Failed to update task'));
        }
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        try {
          await deleteTask(event.taskId);
          final updatedTasks = currentState.tasks
              .where((t) => t.id != event.taskId)
              .toList();
          emit(TaskSuccess(updatedTasks, 'Task deleted successfully'));
          emit(TaskLoaded(updatedTasks));
        } catch (e) {
          emit(TaskError('Failed to delete task: ${e.toString()}'));
          // emit(TaskFailure(currentState.tasks, 'Failed to delete task'));
        }
      }
    });
  }
}
