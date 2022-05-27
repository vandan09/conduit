import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Mytheme {
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    fontFamily: 'TitilliumWeb',
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(
        onPrimary: Colors.grey.shade700, onSecondary: Colors.grey.shade700),
  );

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    fontFamily: 'TitilliumWeb',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.blue),
  );
}
