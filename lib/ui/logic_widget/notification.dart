import 'package:F4Lab/providers/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class NotificationBar extends StatelessWidget {
  static Duration dismissDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final notification = Provider.of<NotificationProvider>(context);
    final notifications = notification.items;

    final items =
        notifications.map<Widget>((item) => _buildItem(item)).toList();

    return Align(
        alignment: Alignment.bottomLeft,
        child: Column(
            children: items,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start));
  }

  Widget _buildItem(NotificationItem item) {
    Color color;
    Color textColor;
    switch (item.type) {
      case Type.ERROR:
        color = Colors.red;
        textColor = Colors.white;
        break;
      case Type.INFO:
      case Type.LOADING:
        color = Colors.grey;
        textColor = Colors.white;
        break;
      case Type.SUCCESS:
        color = Colors.green;
        textColor = Colors.white;
        break;
    }

    Widget loadingWidget;
    if (item.type == Type.LOADING) {
      loadingWidget = LinearProgressIndicator(
        backgroundColor: textColor,
      );
    } else {
      loadingWidget = IgnorePointer();
    }

    return AnimatedOpacity(
        key: Key(item.id),
        opacity: item.dismiss ? 0 : 1,
        duration: dismissDuration,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(12.0)
                  .add(EdgeInsets.only(left: 10, right: 10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      item.content ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                    loadingWidget
                  ]),
            ),
          ),
        ));
  }
}
