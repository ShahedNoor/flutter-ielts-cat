import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts_cat/core/theme/ielts_colors.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: IeltsColors.bg,
  colorScheme: const ColorScheme.light(
    surface: IeltsColors.surface,
    primary: IeltsColors.ink,
    secondary: IeltsColors.accent,
    background: IeltsColors.bg,
    onSurface: IeltsColors.ink,
    onPrimary: IeltsColors.bg,
    onSecondary: IeltsColors.bg,
    onBackground: IeltsColors.ink,
  ),
  textTheme: GoogleFonts.dmSansTextTheme().apply(
    bodyColor: IeltsColors.ink,
    displayColor: IeltsColors.ink,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: IeltsColors.ink),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: IeltsColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: IeltsColors.ink),
    ),
    hintStyle: const TextStyle(color: IeltsColors.inkSoft),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: IeltsColors.ink,
    unselectedItemColor: IeltsColors.inkSoft,
    backgroundColor: IeltsColors.surface,
    selectedLabelStyle: const TextStyle(color: IeltsColors.ink),
    unselectedLabelStyle: const TextStyle(color: IeltsColors.inkSoft),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: IeltsColors.ink,
    selectionColor: IeltsColors.border,
    selectionHandleColor: IeltsColors.ink,
  ),
  dividerColor: IeltsColors.border,
);
