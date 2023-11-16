import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/theme_controller.dart';



class ThemeProvider with ChangeNotifier {
  late ThemeData _selectedTheme;
  late SharedPreferences _prefs;

  ThemeProvider({bool isDark = false}) {
    _selectedTheme = isDark ? darkTheme : lightTheme;
    _initPrefs();
  }

  ThemeData get getTheme => _selectedTheme;

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveTheme(bool isDark) async {
    await _prefs.setBool("isDark", isDark);
  }

  Future<void> toggleTheme() async {
    if (_selectedTheme == darkTheme) {
      _selectedTheme = lightTheme;
      await _saveTheme(false);
    } else {
      _selectedTheme = darkTheme;
      await _saveTheme(true);
    }
    notifyListeners();
  }

  Future<void> setInitialTheme() async {
    final isDark = _prefs.getBool("isDark") ?? false;
    _selectedTheme = isDark ? darkTheme : lightTheme;
    notifyListeners();
  }
}
