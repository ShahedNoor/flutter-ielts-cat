import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey.shade800,
        displayColor: Colors.black,
      ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.grey.shade800, // Set label text color for light mode
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.grey.shade800, // Active label/icon color
    unselectedItemColor: Colors.grey.shade500, // Inactive label/icon color
    backgroundColor: Colors.grey.shade200,
    selectedLabelStyle: TextStyle(color: Colors.grey.shade800),
    unselectedLabelStyle: TextStyle(color: Colors.grey.shade500),
  ),
);
