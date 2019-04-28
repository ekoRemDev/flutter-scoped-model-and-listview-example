import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_scoped_model_and_listview_example/models/user.dart';
import 'package:flutter_scoped_model_and_listview_example/models/todo.dart';

mixin UsersModel on Model {
  List<User> _userList = [];
  Map<int, List<Todo>> _todosMap = {};

  List<User> getUsers() {
    return _userList;
  }

  List<Todo> getTodos(int userId) {
    return _todosMap[userId];
  } 

  void fetchUsers() {
    http.get('http://jsonplaceholder.typicode.com/users')
      .then((response) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        _userList = jsonResponse.map((data) => User.fromJson(data)).toList();
        notifyListeners();
      });
  }

  void fetchTodos(int userId) {
    http.get('https://jsonplaceholder.typicode.com/todos?userId=$userId')
      .then((response) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<Todo> todos = jsonResponse.map((data) => Todo.fromJson(data)).toList();
        _todosMap[userId] = todos;
        notifyListeners();
      });
  }
}
