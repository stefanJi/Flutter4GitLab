import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const.dart';

class ThemeProvider with ChangeNotifier {
  static ThemeData _dark = ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.deepOrange,
      brightness: Brightness.dark);

  static ThemeData _light = ThemeData(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.black,
      brightness: Brightness.light);

  ThemeData _currentTheme = _dark;

  ThemeData get currentTheme => _currentTheme;

  ThemeProvider() {
    _loadFromLocal();
  }

  void switchToDark() {
    debugPrint("switch to dark");
    _currentTheme = _dark;
    _updateLocal(true);
    notifyListeners();
  }

  void switchToLight() {
    debugPrint("switch to light");
    _currentTheme = _light;
    _updateLocal(false);
    notifyListeners();
  }

  void _updateLocal(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(KEY_THEME_IS_DARK, isDark);
  }

  void _loadFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(KEY_THEME_IS_DARK) ?? false;
    _currentTheme = isDark ? _dark : _light;
    notifyListeners();
  }

  bool get isDark => currentTheme == _dark;
}
