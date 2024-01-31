class Task {
  String title;
  String description;
  bool isDone;
  int priority;

  Task(
      {required this.title,
      required this.description,
      required this.isDone,
      required this.priority});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
      priority: map['priority'],
    );
  }
}
