import 'package:flutter/material.dart';
import 'package:flutter_gitlab/widget/comm_ListView.dart';

class Groups extends CommListWidget {
  Groups() : super(canPullUp: false, withPage: false);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends CommListState {
  _State() : super("groups");

  @override
  Widget childBuild(BuildContext context, int index) {
    final item = data[index];
    print("item: $item");
    return _buildItem(item);
  }

  Widget _buildItem(item) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: item['avatar_url'] != null
              ? CircleAvatar(backgroundImage: NetworkImage(item['avatar_url']))
              : CircleAvatar(
                  child: Text(
                      (item['name'] as String).substring(0, 2).toUpperCase()),
                ),
          title: Text(item['name']),
          subtitle: item['description'] != null
              ? Text(item['description'])
              : IgnorePointer(),
          onTap: () {},
        ),
        Divider(height: 2)
      ],
    );
  }
}
