import 'package:flutter/material.dart';

import 'package:flutter_gitlab/page/PageConfig.dart';
import 'package:flutter_gitlab/page/PageHome.dart';

void main() {
  runApp(MaterialApp(
    title: 'GitLab',
    initialRoute: '/',
    theme: ThemeData(primaryColor: Colors.deepOrange[400], brightness: Brightness.dark),
    routes: {
      '/': (context) => HomePage(),
      '/config': (context) => ConfigPage()
    },
  ));
}
