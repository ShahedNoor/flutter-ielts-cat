import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey.shade300,
    displayColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.grey.shade300, // Label color for dark mode
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.grey.shade300, // Active label/icon color
    unselectedItemColor: Colors.grey.shade500, // Inactive label/icon color
    backgroundColor: Colors.grey.shade800,
    selectedLabelStyle: TextStyle(color: Colors.grey.shade300),
    unselectedLabelStyle: TextStyle(color: Colors.grey.shade500),
  ),
);