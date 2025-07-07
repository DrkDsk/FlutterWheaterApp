import 'package:clima_app/core/helpers/theme_helpers.dart';
import 'package:clima_app/features/search/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeHelper.getThemeData(context: context),
      title: 'App del clima',
      home: const HomeWeatherPage(),
    );
  }
}