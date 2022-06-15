import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF2F2F2),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F2F2), foregroundColor: Colors.black),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))))),
    );
  }
}
