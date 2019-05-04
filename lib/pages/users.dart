import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_scoped_model_and_listview_example/scoped-models/main.dart';
import 'package:flutter_scoped_model_and_listview_example/models/user.dart';
import 'package:flutter_scoped_model_and_listview_example/pages/todos.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Users'),
        ),
      ),
      body: _buildListView(context),
    );
  }

  _buildListView(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final userList = model.getUsers();
        return ListView.builder(
          itemBuilder: (context, index) => InkWell(
                splashColor: Colors.blue[300],
                child: _buildListTile(context, userList[index]),
                onTap: () {
                  Route route = MaterialPageRoute(
                    builder: (context) => TodosPage(userList[index]),
                  );
                  Navigator.push(context, route);
                },
              ),
          itemCount: userList.length,
        );
      },
    );
  }

  _buildListTile(BuildContext context, User user) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(user.name),
        subtitle: Text(user.email),
      ),
    );
  }
}
