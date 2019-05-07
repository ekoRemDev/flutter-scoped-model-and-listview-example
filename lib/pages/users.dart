import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_scoped_model_and_listview_example/scoped-models/users.dart';
import 'package:flutter_scoped_model_and_listview_example/widgets/loading.dart';
import 'package:flutter_scoped_model_and_listview_example/models/user.dart';
import 'package:flutter_scoped_model_and_listview_example/pages/todos.dart';

class UsersPage extends StatefulWidget {
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  UsersModel model = UsersModel();

  @override
  void initState() {
    model.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Users'),
        ),
      ),
      body: ScopedModel<UsersModel>(
        model: model,
        child: _buildListView(),
      ),
    );
  }

  _buildListView() {
    return ScopedModelDescendant<UsersModel>(
      builder: (BuildContext context, Widget child, UsersModel model) {
        if (model.loading) {
          return UiLoading();
        }
        final userList = model.users;
        return ListView.builder(
          itemBuilder: (context, index) => InkWell(
                splashColor: Colors.blue[300],
                child: _buildListTile(userList[index]),
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

  _buildListTile(User user) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(user.name),
        subtitle: Text(user.email),
      ),
    );
  }
}
