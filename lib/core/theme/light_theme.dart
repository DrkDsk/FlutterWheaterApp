import 'package:clima_app/core/colors/app_colors_light.dart';
import 'package:flutter/material.dart';

ColorScheme colorScheme = ColorScheme.light(
  onPrimary: AppColorsLight.onPrimary,
  primary: AppColorsLight.primary,
);

ThemeData get lightTheme => ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  colorScheme: colorScheme,
  textTheme: TextTheme(
    bodySmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
    bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: colorScheme.onPrimary),
    bodyLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: colorScheme.onPrimary),
    titleSmall: TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: colorScheme.onPrimary),
    titleMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w700, color: colorScheme.onPrimary),
    titleLarge: TextStyle(fontSize: 55, fontWeight: FontWeight.w700, color: colorScheme.onPrimary),
  ),
  scaffoldBackgroundColor: Colors.white
);