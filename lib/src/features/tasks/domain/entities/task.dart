// entitas, bedanya sama model/task kalau yang model tadi fokus komunikasi sama server (json), kalau yang entitas fokus ke logika bisnis
// mudahnya yang model tadi data mentah, yang ini data siap pakai (gaperlu converter antara json ke object dan sebaliknya)

class Task {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Task({
    required this.userId,
    required this.id,
    required this.title,
    this.completed = false,
  });
}
