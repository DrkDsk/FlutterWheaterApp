import 'dart:ui';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
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

  WeatherData(
      {required this.currentWeather,
      required this.translatedWeather,
      required this.hourly,
      required this.daily,
      required this.city});

  Color getBackgroundColor() {
    final mainTranslatedWeatherDescription = translatedWeather.main;
    if (mainTranslatedWeatherDescription == null) {
      return WeatherColors.drizzleNight;
    }

    final weather = currentWeather;

    final isNightTime = DateTimeTimeHelper.isNight(
      DateTime.now(),
      weather.sunrise,
      weather.sunset,
    );

    final timeType = isNightTime ? TimeOfDayType.night : TimeOfDayType.day;
    return WeatherColors.getWeatherColor(
        mainTranslatedWeatherDescription, timeType);
  }

  @override
  List<Object?> get props =>
      [currentWeather, translatedWeather, hourly, daily, city];
}
