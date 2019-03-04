import 'package:F4Lab/const.dart';
import 'package:F4Lab/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Stetho.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool(KEY_THEME_IS_DARK) ?? false;
  runApp(MyApp(isDark));
}
