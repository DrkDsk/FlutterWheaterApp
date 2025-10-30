import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BackgroundWeather with EquatableMixin {
  final String lottiePath;
  final Color color;

  const BackgroundWeather({
    required this.lottiePath,
    required this.color,
  });

  factory BackgroundWeather.initial() {
    return BackgroundWeather(
      lottiePath: WeatherLottieConstants.loadingLottie,
      color: Colors.white10,
    );
  }

  @override
  List<Object?> get props => [lottiePath, color];
}
