enum TaskPriority { low, medium, high }

class Task {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  final bool isCompleted;
  final TaskPriority priority;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.priority = TaskPriority.medium, // Default priority
  });

  // Convert Task to a Map for SQLite storage
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate,
    'isCompleted': isCompleted ? 1 : 0, // Store boolean as 1 or 0
    'priority': priority.index, // Store enum as index (0 = Low, 1 = Medium, 2 = High)
  };

  // Convert Map from SQLite to a Task object
  static Task fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    dueDate: map['dueDate'],
    isCompleted: map['isCompleted'] == 1, // Convert 1 or 0 to bool
    priority: TaskPriority.values[map['priority']], // Convert index to TaskPriority
  );
}

