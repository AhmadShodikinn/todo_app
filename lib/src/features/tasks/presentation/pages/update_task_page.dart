import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';

// class UpdateTaskPage extends StatefulWidget {
//   final Task task;

//   const UpdateTaskPage({super.key, required this.task});

//   @override
//   State<UpdateTaskPage> createState() => _UpdateTaskPageState();
// }

void showUpdateTaskSheet(BuildContext context, Task task) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController(
    text: task.title,
  );

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Task",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter task title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedTask = Task(
                        id: task.id,
                        title: _titleController.text,
                        isCompleted: task.isCompleted,
                      );

                      context.read<TaskBloc>().add(
                        UpdateTaskEvent(updatedTask),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
