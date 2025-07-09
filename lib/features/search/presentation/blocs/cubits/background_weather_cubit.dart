import 'dart:async';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundWeatherCubit extends Cubit<Color?> {
  final WeatherCubit _weatherCubit;
  late final StreamSubscription weatherSubscription;

  BackgroundWeatherCubit(this._weatherCubit) : super(Colors.blue[300]) {
    weatherSubscription = _weatherCubit.stream.listen((weatherState) {
      _mapWeatherToTheme(
          translatedWeather: weatherState.translatedWeather,
          weather: weatherState.currentWeather);
    });
  }

  void _mapWeatherToTheme(
      {required TranslatedWeather? translatedWeather,
      required Current? weather}) {
    if (translatedWeather == null  || weather == null) return;

    final isNightTime = DateTimeTimeHelper.isNight(
      DateTime.now(),
      weather.sunrise,
      weather.sunset,
    );

    final timeType = isNightTime ? TimeOfDayType.night : TimeOfDayType.day;
    emit(WeatherColors.getWeatherColor(translatedWeather.main!, timeType));
  }
}
