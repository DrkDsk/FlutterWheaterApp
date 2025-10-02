import 'dart:ui';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/home/domain/entities/forecast.dart';
import 'package:equatable/equatable.dart';

class CityWeatherData with EquatableMixin {
  final Forecast forecast;
  final TranslatedWeather translatedWeather;
  final String city;

  CityWeatherData(
      {required this.forecast,
      required this.translatedWeather,
      required this.city});

  Color getBackgroundColor() {
    final mainTranslatedWeatherDescription = translatedWeather.main;
    if (mainTranslatedWeatherDescription == null) {
      return WeatherColors.drizzleNight;
    }

    final currentWeather = forecast.current;

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
  List<Object?> get props => [forecast, translatedWeather, city];
}
