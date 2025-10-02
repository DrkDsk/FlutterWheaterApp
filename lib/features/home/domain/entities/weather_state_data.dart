import 'dart:ui';

import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:equatable/equatable.dart';

class WeatherData with EquatableMixin {
  final Current currentWeather;
  final TranslatedWeather translatedWeather;
  final List<Hourly> hourly;
  final List<Daily> daily;
  final String city;
  final int? cityId;
  final Color? backgroundColor;

  WeatherData(
      {required this.currentWeather,
      required this.translatedWeather,
      required this.hourly,
      required this.daily,
      required this.city,
      required this.cityId,
      this.backgroundColor});

  @override
  List<Object?> get props => [
        currentWeather,
        translatedWeather,
        hourly,
        daily,
        city,
        cityId,
        backgroundColor
      ];
}
