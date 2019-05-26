import 'package:flutter/material.dart';

Widget loadAvatar(url, name, {color = Colors.teal}) {
  assert(name != null);
  if (url != null) {
    NetworkImage image;
    try {
      image = new NetworkImage(url);
      return CircleAvatar(
        backgroundImage: image,
      );
    } catch (Exception) {
      print("Load avatar error: $Exception");
    }
  }
  return new CircleAvatar(
    child: Text(
      name,
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
    ),
    backgroundColor: color,
  );
}
