import 'package:F4Lab/model/todo.dart' as TodoModel;
import 'package:F4Lab/util/widget_util.dart';
import 'package:F4Lab/widget/comm_ListView.dart';
import 'package:flutter/material.dart';

class TabTodo extends CommListWidget {
  @override
  State<StatefulWidget> createState() => TodoState();
}

class TodoState extends CommListState<TabTodo> {
  @override
  Widget childBuild(BuildContext context, int index) {
    final todoItem = TodoModel.Todo.fromJson(data[index]);
    return Card(
        child: ExpansionTile(
      leading: loadAvatar(todoItem.author?.avatarUrl, todoItem.author?.name),
      title: Text.rich(TextSpan(
          text: "${todoItem.author?.name} ",
          style: TextStyle(fontWeight: FontWeight.w100),
          children: [
            TextSpan(
                text: todoItem.actionName.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: " ${todoItem.targetType} ",
                style: TextStyle(fontWeight: FontWeight.w400)),
            TextSpan(text: todoItem.target?.title)
          ])),
      trailing: OutlinedButton(
        child: Text("Done"),
        onPressed: () {},
      ),
      children: <Widget>[Text(todoItem.createdAt)],
    ));
  }

  @override
  String endPoint() => "todos?state=pending";
}
