import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_scoped_model_and_listview_example/models/user.dart';
import './base.dart';

class UsersModel extends BaseModel {
  List<User> _userList = [];

  List<User> get users => _userList;

  set _users(List<User> value) {
    _userList = value;
    notifyListeners();
  }

  void fetchUsers() {
    loading = true;
    http.get('http://jsonplaceholder.typicode.com/users')
      .then((response) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        _users = jsonResponse.map((data) => User.fromJson(data)).toList();
        loading = false;
      });
  }
}
