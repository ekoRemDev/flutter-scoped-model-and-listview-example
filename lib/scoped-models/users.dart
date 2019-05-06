import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_scoped_model_and_listview_example/models/user.dart';

class UsersModel extends Model {
  List<User> _userList = [];

  List<User> get users => _userList;

  set _users(List<User> value) {
    _userList = value;
    notifyListeners();
  }

  void fetchUsers() {
    http.get('http://jsonplaceholder.typicode.com/users').then((response) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      _users = jsonResponse.map((data) => User.fromJson(data)).toList();
    });
  }
}
