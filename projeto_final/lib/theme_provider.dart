import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider({required bool isDarkMode})
      : _themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData.brightness == Brightness.dark;

  ThemeData getTheme({Color? scaffoldBackgroundColor}) {
    return _themeData.copyWith(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
    );
  }

  void toggleTheme() {
    _themeData = _themeData.brightness == Brightness.dark
        ? ThemeData.light()
        : ThemeData.dark();
    notifyListeners();
  }
}
