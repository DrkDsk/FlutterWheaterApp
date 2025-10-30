import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:flutter/material.dart';

class BackgroundWeatherHelper {
  static Map<String, Map<TimeOfDayType, String>> weatherLottie = {
    "Clear": {
      TimeOfDayType.day: WeatherLottieConstants.clearDay,
      TimeOfDayType.night: WeatherLottieConstants.clearNight,
    },
    "Clouds": {
      TimeOfDayType.day: WeatherLottieConstants.cloudDay,
      TimeOfDayType.night: WeatherLottieConstants.cloudNight,
    },
    "Rain": {
      TimeOfDayType.day: WeatherLottieConstants.rainDay,
      TimeOfDayType.night: WeatherLottieConstants.rainNight,
    },
    "Snow": {
      TimeOfDayType.day: WeatherLottieConstants.snowDay,
      TimeOfDayType.night: WeatherLottieConstants.snowNight,
    },
    "Thunderstorm": {
      TimeOfDayType.day: WeatherLottieConstants.thunderstormDay,
      TimeOfDayType.night: WeatherLottieConstants.thunderstormNight,
    },
    "Drizzle": {
      TimeOfDayType.day: WeatherLottieConstants.drizzleDay,
      TimeOfDayType.night: WeatherLottieConstants.drizzleNight,
    },
    "Atmosphere": {
      TimeOfDayType.day: WeatherLottieConstants.atmosphereDay,
      TimeOfDayType.night: WeatherLottieConstants.atmosphereNight,
    },
  };

  static Map<String, Map<TimeOfDayType, Color>> weatherColors = {
    "Clear": {
      TimeOfDayType.day: WeatherColorConstants.clearDay,
      TimeOfDayType.night: WeatherColorConstants.clearNight,
    },
    "Clouds": {
      TimeOfDayType.day: WeatherColorConstants.cloudDay,
      TimeOfDayType.night: WeatherColorConstants.cloudNight,
    },
    "Rain": {
      TimeOfDayType.day: WeatherColorConstants.rainDay,
      TimeOfDayType.night: WeatherColorConstants.rainNight,
    },
    "Snow": {
      TimeOfDayType.day: WeatherColorConstants.snowDay,
      TimeOfDayType.night: WeatherColorConstants.snowNight,
    },
    "Thunderstorm": {
      TimeOfDayType.day: WeatherColorConstants.thunderstormDay,
      TimeOfDayType.night: WeatherColorConstants.thunderstormNight,
    },
    "Drizzle": {
      TimeOfDayType.day: WeatherColorConstants.drizzleDay,
      TimeOfDayType.night: WeatherColorConstants.drizzleNight,
    },
    "Atmosphere": {
      TimeOfDayType.day: WeatherColorConstants.atmosphereDay,
      TimeOfDayType.night: WeatherColorConstants.atmosphereNight,
    },
  };

  static String getWeatherLottie({
    required String weatherType,
    required TimeOfDayType time,
  }) {
    return weatherLottie[weatherType]?[time] ??
        WeatherLottieConstants.loadingLottie;
  }

  static Color getWeatherBackgroundColor({
    required String weatherType,
    required TimeOfDayType time,
  }) {
    return weatherColors[weatherType]?[time] ?? Colors.white10;
  }
}
