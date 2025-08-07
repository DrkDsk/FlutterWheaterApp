import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeatherColors.cloudDay,
      body: Lottie.asset(
        "assets/lottie/loading_splash.json",
        width: double.infinity,
        height: double.infinity
      ),
    );
  }
}