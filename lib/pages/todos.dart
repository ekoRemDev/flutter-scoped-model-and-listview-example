import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_scoped_model_and_listview_example/scoped-models/main.dart';
import 'package:flutter_scoped_model_and_listview_example/models/user.dart';
import 'package:flutter_scoped_model_and_listview_example/models/todo.dart';

class TodosPage extends StatelessWidget {
  final User user;

  TodosPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text(
                  'Todos',
                  style: TextStyle(
                    fontSize: 18.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: _buildListView(context),
            ),
          ],
        ),
      ),
    );
  }

  _buildListView(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final todoList = model.getTodos(user.id);
        return ListView.builder(
          itemBuilder: (context, index) =>
              _buildListTile(context, todoList[index]),
          itemCount: todoList.length,
        );
      },
    );
  }

  _buildListTile(BuildContext context, Todo todo) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(todo.title),
              leading: Switch(
                value: todo.completed,
                activeColor: Theme.of(context).accentColor,
                onChanged: (value) {},
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
