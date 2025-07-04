import 'package:flutter/material.dart';

const colorScheme = ColorScheme.light(
  onPrimary: Colors.white,
  primary: Colors.blue,
  secondary: Colors.amber,
);

ThemeData get lightTheme => ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  colorScheme: colorScheme,
  textTheme: TextTheme(
    bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
    bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
    bodyLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: colorScheme.onPrimary),
    titleLarge: TextStyle(fontSize: 60, fontWeight: FontWeight.w700, color: colorScheme.onPrimary),
  ),
  scaffoldBackgroundColor: Colors.white
);