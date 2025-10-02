import 'dart:ui';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:equatable/equatable.dart';

import 'forecast.dart';

class CityWeatherData with EquatableMixin {
  final Forecast forecast;
  final String cityName;
  final TranslatedWeather translatedWeather;

  CityWeatherData(
      {required this.forecast,
      required this.cityName,
      required this.translatedWeather});

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
  List<Object?> get props => [forecast, cityName, translatedWeather];
}
