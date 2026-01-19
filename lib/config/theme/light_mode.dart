import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: const Color.fromARGB(255, 189, 189, 189),
    inversePrimary: Colors.grey.shade800,
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey.shade800,
    displayColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.grey.shade800),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade600,
      ), // Default border color
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blueGrey.shade700,
      ), // Focused border color
    ),
    hintStyle: TextStyle(color: Colors.grey.shade600), // Hint text color
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.grey.shade800, // Active label/icon color
    unselectedItemColor: Colors.grey.shade500, // Inactive label/icon color
    backgroundColor: Colors.grey.shade200,
    selectedLabelStyle: TextStyle(color: Colors.grey.shade800),
    unselectedLabelStyle: TextStyle(color: Colors.grey.shade500),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.blueGrey.shade700, // Set your desired cursor color
    selectionColor: Colors.grey.shade400, // Optional: selected text color
    selectionHandleColor: Colors.blueGrey.shade700, // Optional: handle/bubble color
  ),
);
