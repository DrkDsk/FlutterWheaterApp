import 'dart:ui';

import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';

class WeatherStateData {
  final Current currentWeather;
  final TranslatedWeather translatedWeather;
  final List<Hourly> hourly;
  final List<Daily> daily;
  final String city;
  final int? cityId;
  final double? latitude;
  final double? longitude;
  final Color? backgroundColor;

  WeatherStateData({
    required this.currentWeather,
    required this.translatedWeather,
    required this.hourly,
    required this.daily,
    required this.city,
    required this.cityId,
    required this.latitude,
    required this.longitude,
    this.backgroundColor
  });
}