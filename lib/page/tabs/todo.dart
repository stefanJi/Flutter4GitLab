import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

class Todo extends CommListWidget {
  @override
  State<StatefulWidget> createState() => TodoState();
}

class TodoState extends CommListState {
  TodoState() : super("todos?state=pending");

  @override
  Widget childBuild(BuildContext context, int index) {
    final todoItem = data[index];
    return Card(
        child: ExpansionTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(todoItem['author']['avatar_url']),
      ),
      title: Text.rich(TextSpan(
          text: "${todoItem['author']['name']} ",
          style: TextStyle(fontWeight: FontWeight.w100),
          children: [
            TextSpan(
                text: (todoItem['action_name'] as String).toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: " ${todoItem['target_type']} ",
                style: TextStyle(fontWeight: FontWeight.w400)),
            TextSpan(text: todoItem['target']['title'])
          ])),
      trailing: OutlineButton(
        child: Text("Done"),
        onPressed: () {},
      ),
      children: <Widget>[Text(todoItem['created_at'])],
    ));
  }
}
