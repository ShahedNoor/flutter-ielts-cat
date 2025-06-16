import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: const Color.fromARGB(255, 66, 66, 66), // Inverted secondary
    inversePrimary: Colors.grey.shade200,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey.shade200,
    displayColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey.shade200),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey.shade300),
    ),
    hintStyle: TextStyle(color: Colors.grey.shade400),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.grey.shade200,
    unselectedItemColor: Colors.grey.shade500,
    backgroundColor: Colors.grey.shade900,
    selectedLabelStyle: TextStyle(color: Colors.grey.shade200),
    unselectedLabelStyle: TextStyle(color: Colors.grey.shade500),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.blueGrey.shade300, // Contrasts with grey.shade800
    selectionColor: Colors.grey.shade600, // Lighter selection color
    selectionHandleColor: Colors.blueGrey.shade300, // Matches cursor
  ),
);