import 'dart:ui';

import 'package:clima_app/features/home/domain/entities/city_weather_data.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';

class WeatherStatusContentData {
  final CityWeatherStatus status;
  final CityWeatherData? data;
  final Color bgColor;

  const WeatherStatusContentData({
    required this.status,
    required this.bgColor,
    this.data,
  });
}
