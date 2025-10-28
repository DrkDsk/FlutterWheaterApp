import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Lottie.asset(
        WeatherLottieConstants.loadingLottie,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
