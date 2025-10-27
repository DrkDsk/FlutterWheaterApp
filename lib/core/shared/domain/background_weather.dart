import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:flutter/material.dart';

class BackgroundWeather {
  final String lottiePath;
  final Color color;

  const BackgroundWeather({required this.lottiePath, required this.color});

  factory BackgroundWeather.initial() {
    return BackgroundWeather(
        lottiePath: WeatherConstants.loadingLottie, color: Colors.white10);
  }
}
