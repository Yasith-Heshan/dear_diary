import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
        headlineLarge: TextStyle(
            fontSize: 35, color: Colors.blue[700], fontWeight: FontWeight.w400),
        headlineMedium: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 30,
        ),
        headlineSmall: const TextStyle(color: Colors.white54, fontSize: 20),
        bodyLarge: const TextStyle(color: Colors.white, fontSize: 17),
        titleMedium: const TextStyle(
          color: Colors.black,
        )),
  );
}
