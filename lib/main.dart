import 'package:clima_app/core/theme/dark_theme.dart';
import 'package:clima_app/core/theme/light_theme.dart';
import 'package:clima_app/features/search/presentation/pages/show_weather_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: 'App del clima',
      home: const ShowWeatherPage(),
    );
  }
}
