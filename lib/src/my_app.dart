import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:clima_app/core/theme/light_theme.dart';
import 'package:clima_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheAnimations();
  }

  Future<void> _precacheAnimations() async {
    final animationsPath = WeatherLottieConstants.precacheAnimations;

    for (final path in animationsPath) {
      await AssetLottie(path).load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'App del clima',
      home: const HomeScreen(),
    );
  }
}
