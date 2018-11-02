import 'package:F4Lab/page/PageConfig.dart';
import 'package:F4Lab/page/PageHome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'GitLab',
    initialRoute: '/',
    theme: ThemeData(
        primaryColor: Colors.deepOrange[400], brightness: Brightness.dark),
    routes: {
      '/': (context) => HomePage(),
      '/config': (context) => ConfigPage()
    },
  ));
}
