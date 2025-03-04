class Todo {
  int? id;
  String title;
  String time;
  bool isToday;
  bool isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.time,
    this.isToday = false,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'isToday': isToday ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      time: map['time'],
      isToday: map['isToday'] == 1,
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
