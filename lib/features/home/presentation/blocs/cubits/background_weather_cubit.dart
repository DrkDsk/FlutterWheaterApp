import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundWeatherCubit extends Cubit<Color?> {

  BackgroundWeatherCubit() : super(Colors.blue[300]);

  void updateFromWeatherData({
    required WeatherStateData weatherStateData
  }) {
    final translatedWeather = weatherStateData.translatedWeather;
    final weather = weatherStateData.currentWeather;

    final isNightTime = DateTimeTimeHelper.isNight(
      DateTime.now(),
      weather.sunrise,
      weather.sunset,
    );

    final timeType = isNightTime ? TimeOfDayType.night : TimeOfDayType.day;
    final newColor = WeatherColors.getWeatherColor(translatedWeather.main!, timeType);

    if (newColor != state) emit(newColor);
  }
}
