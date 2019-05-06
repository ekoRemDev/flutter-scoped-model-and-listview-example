import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_scoped_model_and_listview_example/models/todo.dart';

class TodosModel extends Model {
  List<Todo> _todoList = [];

  List<Todo> get todos => _todoList;

  set _todos(List<Todo> value) {
    _todoList = value;
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    final index = todos.indexWhere((e) => e.id == todo.id);
    if (index >= 0) {
      todos[index] = todo;
      notifyListeners();
    }
  }

  void fetchTodos(int userId) {
    http
        .get('https://jsonplaceholder.typicode.com/todos?userId=$userId')
        .then((response) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      _todos = jsonResponse.map((data) => Todo.fromJson(data)).toList();
    });
  }
}
