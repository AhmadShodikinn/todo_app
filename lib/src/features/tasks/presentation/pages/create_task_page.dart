import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../../domain/entities/task.dart';

void showCreateTaskSheet(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

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
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: titleController,
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
                    if (formKey.currentState!.validate()) {
                      final newTask = Task(
                        id: 0,
                        title: titleController.text,
                        isCompleted: false,
                      );

                      context.read<TaskBloc>().add(AddTaskEvent(newTask));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
