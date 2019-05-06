import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_scoped_model_and_listview_example/scoped-models/todos.dart';
import 'package:flutter_scoped_model_and_listview_example/models/user.dart';
import 'package:flutter_scoped_model_and_listview_example/models/todo.dart';

class TodosPage extends StatefulWidget {
  final User user;

  TodosPage(this.user);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  TodosModel model = TodosModel();

  @override
  void initState() {
    model.fetchTodos(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
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
              child: ScopedModel<TodosModel>(
                model: model,
                child: _buildListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildListView() {
    return ScopedModelDescendant<TodosModel>(
      builder: (BuildContext context, Widget child, TodosModel model) {
        final todoList = model.todos;
        return ListView.builder(
          itemBuilder: (context, index) => _buildListTile(todoList[index]),
          itemCount: todoList.length,
        );
      },
    );
  }

  _buildListTile(Todo todo) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(todo.title),
          leading: Switch(
            value: todo.completed,
            activeColor: Theme.of(context).accentColor,
            onChanged: (value) {
              model.updateTodo(Todo(
                id: todo.id,
                title: todo.title,
                completed: value,
              ));
            },
          ),
        ),
        Divider(),
      ],
    );
  }
}
