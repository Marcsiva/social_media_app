import 'package:flutter/material.dart';

// LightTheme
ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade100,
  primaryColor: Colors.grey,
  iconTheme: const IconThemeData(color: Color(0xFF011E3D)),
  // iconTheme: const IconThemeData(color: Color(0xFF3FB58B)),
  colorScheme: const ColorScheme.light(),

);

// DarkTheme
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade900,
  primaryColor: Colors.grey.shade700,
  buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF3FB58B)),
  iconTheme: const IconThemeData(color : Colors.grey),
  // iconTheme: const IconThemeData(color: Color(0xFF011E3D)),
  colorScheme: const ColorScheme.dark(),
);

