import 'dart:async';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundWeatherCubit extends Cubit<Color?> {
  final WeatherBloc _weatherBloc;
  late final StreamSubscription weatherSubscription;

  BackgroundWeatherCubit(this._weatherBloc) : super(Colors.blue[300]) {
    weatherSubscription = _weatherBloc.stream.listen((weatherState) {
      if (weatherState is WeatherSuccessState) {
        _mapWeatherToTheme(
            translatedWeather: weatherState.weatherData.translatedWeather,
            weather: weatherState.weatherData.currentWeather);
      }
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
