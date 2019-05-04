import 'package:flutter/material.dart';
import './users.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutte App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('User list and respective Todos'),
            SizedBox(height: 16.0),
            RaisedButton(
              child: Text('Continue'),
              onPressed: () {
                Route route = MaterialPageRoute(
                  builder: (context) => UsersPage(),
                );
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
