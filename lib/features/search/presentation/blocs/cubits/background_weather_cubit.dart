import 'dart:async';

import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundWeatherCubit extends Cubit<Color?>{

  final WeatherCubit _weatherCubit;
  late final StreamSubscription weatherSubscription;

  BackgroundWeatherCubit(this._weatherCubit) : super(Colors.blue[300]) {
    weatherSubscription = _weatherCubit.stream.listen((weatherState) {
      _mapWeatherToTheme(weatherState.translatedWeather);
    });
  }

  void _mapWeatherToTheme(TranslatedWeather? translatedWeather) {
    if (translatedWeather == null) return;

    emit(WeatherColors.currentWeatherColor(translatedWeather.main));
  }
}