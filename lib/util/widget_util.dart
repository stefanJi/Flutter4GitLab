import 'package:flutter/material.dart';

Widget loadAvatar(String url, String name, {Color color = Colors.teal}) {
  assert(name != null);
  if (url != null) {
    debugPrint("[loadAvatar] Start load: $url");
    NetworkImage image;
    image = new NetworkImage(url);
    return CircleAvatar(
      backgroundImage: image,
      backgroundColor: color,
    );
  }
  return new CircleAvatar(
    child: Text(
      name,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    ),
    backgroundColor: color,
  );
}
