class Todo {
  final int id;
  final String title;
  final bool completed;

  const Todo({
    this.id,
    this.title,
    this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      title: data['title'],
      completed: data['completed'],
    );
  }
}
