import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/Palette.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 14, 14, 14)),
    primaryColor: const Color.fromARGB(255, 14, 14, 14),
    secondaryHeaderColor: Palette.pink,
    shadowColor: const Color.fromARGB(255, 14, 14, 14),
    hoverColor: const Color.fromARGB(255, 114, 114, 114),
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(color: Palette.blue),
    primaryColor: Palette.blue,
    secondaryHeaderColor: Palette.pink,
    shadowColor: Palette.lightGrey,
    hoverColor: Palette.grey,
    colorScheme: const ColorScheme.light(),
  );
}
