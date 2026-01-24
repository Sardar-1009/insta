import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const bg = Colors.black;
  const fg = Colors.white;

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: bg,
      foregroundColor: fg,
      elevation: 0,
      centerTitle: false,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bg,
      selectedItemColor: fg,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    dividerColor: Colors.white12,
    useMaterial3: true,
  );
}
