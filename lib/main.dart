import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/src/core/network/api_client.dart';

import 'package:todo_list_app/src/features/tasks/data/datasources/task_datasources.dart';
import 'package:todo_list_app/src/features/tasks/data/repositories/task_repository_data.dart';
import 'package:todo_list_app/src/features/tasks/domain/usecases/get_tasks.dart';
import 'package:todo_list_app/src/features/tasks/domain/usecases/create_task.dart';
import 'package:todo_list_app/src/features/tasks/domain/usecases/update_task.dart';
import 'package:todo_list_app/src/features/tasks/domain/usecases/delete_task.dart';
import 'package:todo_list_app/src/features/tasks/presentation/bloc/task_bloc.dart';
// import 'package:todo_list_app/src/features/tasks/presentation/pages/task_list_page.dart';
import 'package:todo_list_app/src/features/greetings/presentation/welcome_page.dart';

void main() {
  final apiClient = ApiClient();
  final taskDataSource = TaskDataSourcesImpl(apiClient: apiClient);
  final taskRepository = TaskRepositoryData(taskDataSource);

  final getTasks = GetTasks(taskRepository);
  final createTask = CreateTask(taskRepository);
  final updateTask = UpdateTask(taskRepository);
  final deleteTask = DeleteTask(taskRepository);

  runApp(
    BlocProvider(
      create: (_) => TaskBloc(
        getTasks: getTasks,
        createTask: createTask,
        updateTask: updateTask,
        deleteTask: deleteTask,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Manager', home: const WelcomePage());
  }
}

// class MyApp extends StatelessWidget {
//   final GetTasks getTasksUseCase;
//   final CreateTask createTaskUseCase;
//   final UpdateTask updateTaskUseCase;
//   final DeleteTask deleteTaskUseCase;

//   const MyApp({
//     super.key,
//     required this.getTasksUseCase,
//     required this.createTaskUseCase,
//     required this.updateTaskUseCase,
//     required this.deleteTaskUseCase,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Task Manager',
//       home: BlocProvider(
//         create: (_) => TaskBloc(
//           getTasks: getTasksUseCase,
//           createTask: createTaskUseCase,
//           updateTask: updateTaskUseCase,
//           deleteTask: deleteTaskUseCase,
//         ),
//         child: const TaskListPage(),
//       ),
//     );
//   }
// }
