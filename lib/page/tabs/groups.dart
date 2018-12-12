import 'package:flutter/material.dart';
import 'package:F4Lab/widget/comm_ListView.dart';

class Groups extends CommListWidget {
  Groups() : super(canPullUp: false, withPage: false);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends CommListState {
  _State() : super("groups");

  @override
  Widget build(BuildContext context) {
    return data != null
        ? GridView.builder(
            itemCount: data.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return childBuild(context, index);
            }).build(context)
        : super.build(context);
  }

  @override
  Widget childBuild(BuildContext context, int index) {
    final item = data[index];
    return _buildItem(item);
  }

  Widget _buildItem(item) {
    return Card(
      child: InkWell(
        onTap: () {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("${item['name']}: ${item['description']}"),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 40,
              child: Text(
                item['name'],
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
