import 'package:clima_app/core/theme/light_theme.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'App del clima',
      home: const HomeWeatherPage(),
    );
  }
}
