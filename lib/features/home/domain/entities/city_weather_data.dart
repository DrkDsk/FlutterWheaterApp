import 'dart:ui';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/home/domain/entities/home_weather_data.dart';
import 'package:equatable/equatable.dart';

class CityWeatherData with EquatableMixin {
  final HomeWeatherData weatherData;

  CityWeatherData({required this.weatherData});

  Color getBackgroundColor() {
    final mainTranslatedWeatherDescription = weatherData.translatedWeather.main;
    if (mainTranslatedWeatherDescription == null) {
      return WeatherColors.drizzleNight;
    }

    final currentWeather = weatherData.forecast.current;

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
  List<Object?> get props => [weatherData];
}
