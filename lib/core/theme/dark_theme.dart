import 'package:flutter/material.dart';

const colorScheme = ColorScheme.dark(
  onPrimary: Colors.white,
  primary: Colors.black,
  secondary: Colors.deepOrange,
);

ThemeData get darkTheme => ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Montserrat',
  textTheme: TextTheme(
    bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
    bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
    bodyLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: colorScheme.onPrimary),
    titleLarge: TextStyle(fontSize: 60, fontWeight: FontWeight.w700, color: colorScheme.onPrimary),
  ),
  scaffoldBackgroundColor: Colors.black,
  colorScheme: colorScheme,
);