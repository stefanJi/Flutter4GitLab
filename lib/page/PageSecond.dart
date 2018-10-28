import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String title;

  SecondScreen({Key key, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: RaisedButton(
          child: Text("Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
