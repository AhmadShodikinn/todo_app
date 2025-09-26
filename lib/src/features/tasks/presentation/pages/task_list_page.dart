import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/src/features/tasks/domain/entities/task.dart';
import 'package:todo_list_app/src/features/tasks/presentation/pages/update_task_page.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../widgets/rename_list_dialog.dart';
import 'create_task_page.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  String listTitle = 'Today Task';

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadTaskEvent());
  }

  void _showRenameDialog() {
    showDialog(
      context: context,
      builder: (_) => RenameListDialog(
        initialValue: listTitle,
        onRename: (newName) {
          setState(() {
            listTitle = newName;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskSuccess && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
        } else if (state is TaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfff8f6fb),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: SafeArea(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  int total = 0;
                  int completed = 0;
                  if (state is TaskLoaded) {
                    total = state.tasks.length;
                    completed = state.tasks.where((t) => t.isCompleted).length;
                  }
                  //container selurunya
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.menu_rounded),
                              color: Colors.grey.shade600,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Coming soon!')),
                                );
                              },
                            ),
                            const Spacer(),
                            Text(
                              'To Do List',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 13,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.search),
                              color: Colors.grey.shade600,
                              onPressed: () {
                                // search action
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Coming soon!')),
                                );
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    listTitle,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 2,
                                      left: 4,
                                    ),
                                    child: Text(
                                      '$completed/$total',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.edit_note),
                              color: Colors.grey.shade700,
                              onPressed: _showRenameDialog,
                            ),

                            PopupMenuButton<int>(
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.grey.shade700,
                              ),
                              itemBuilder: (ctx) => [
                                const PopupMenuItem(
                                  value: 1,
                                  child: Text('Sort'),
                                ),
                                const PopupMenuItem(
                                  value: 2,
                                  child: Text('Clear completed'),
                                ),
                              ],
                              onSelected: (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Coming soon!')),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          body: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TaskLoaded) {
                final tasks = state.tasks;

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  itemCount:
                      tasks.length + 1, // +1 untuk baris "tambahkan data"
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () {
                          showCreateTaskSheet(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withValues(
                              alpha: 0.08,
                            ), // transparan
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.deepPurple.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add, color: Colors.deepPurple),
                              SizedBox(width: 6),
                              Text(
                                "Add New Task",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final task = tasks[index - 1];
                    return Dismissible(
                      key: ValueKey(task.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                      },
                      child: GestureDetector(
                        onTap: () {
                          showUpdateTaskSheet(context, task);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  final updateTask = Task(
                                    id: task.id,
                                    title: task.title,
                                    isCompleted: !task.isCompleted,
                                  );
                                  context.read<TaskBloc>().add(
                                    UpdateTaskEvent(updateTask),
                                  );
                                },
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                    color: task.isCompleted
                                        ? Colors.deepPurple
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showUpdateTaskSheet(context, task);
                                  },
                                  child: Text(
                                    task.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: task.isCompleted
                                          ? Colors.grey
                                          : Colors.black,
                                      decoration: task.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is TaskError) {
                return Center(child: Text("Error: ${state.message}"));
              }
              return const Center(child: Text("Empty Data!"));
            },
          ),
        );
      },
    );
  }
}
