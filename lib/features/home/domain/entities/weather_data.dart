import 'dart:ui';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/home/domain/entities/weather_response.dart';
import 'package:equatable/equatable.dart';

class WeatherData with EquatableMixin {
  final WeatherResponse weather;
  final TranslatedWeather translatedWeather;
  final String city;

  WeatherData(
      {required this.weather,
      required this.translatedWeather,
      required this.city});

  Color getBackgroundColor() {
    final mainTranslatedWeatherDescription = translatedWeather.main;
    if (mainTranslatedWeatherDescription == null) {
      return WeatherColors.drizzleNight;
    }

    final currentWeather = weather.current;

    final isNightTime = DateTimeTimeHelper.isNight(
      DateTime.now(),
      currentWeather.sunrise,
      currentWeather.sunset,
    );

    final timeType = isNightTime ? TimeOfDayType.night : TimeOfDayType.day;
    return WeatherColors.getWeatherColor(
        mainTranslatedWeatherDescription, timeType);
  }

  @override
  List<Object?> get props => [weather, translatedWeather, city];
}
