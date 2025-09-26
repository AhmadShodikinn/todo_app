class Task {
  final int id;
  final String title;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}
