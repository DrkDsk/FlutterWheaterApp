import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:flutter/material.dart';

class BackgroundWeatherHelper {
  static Map<String, Map<TimeOfDayType, String>> weatherLottie = {
    "Clear": {
      TimeOfDayType.day: "assets/lottie/clear_day.json",
      TimeOfDayType.night: "assets/lottie/clear_night.json",
    },
    "Clouds": {
      TimeOfDayType.day: "assets/lottie/cloud_day.json",
      TimeOfDayType.night: "assets/lottie/cloud_day.json",
    },
    "Rain": {
      TimeOfDayType.day: "assets/lottie/rain.json",
      TimeOfDayType.night: "assets/lottie/rain.json",
    },
    "Snow": {
      TimeOfDayType.day: "assets/lottie/snow.json",
      TimeOfDayType.night: "assets/lottie/snow.json",
    },
    "Thunderstorm": {
      TimeOfDayType.day: "assets/lottie/thunder_day.json",
      TimeOfDayType.night: "assets/lottie/thunder_night.json",
    },
    "Drizzle": {
      TimeOfDayType.day: "assets/lottie/drizzle.json",
      TimeOfDayType.night: "assets/lottie/drizzle.json",
    },
    "Atmosphere": {
      TimeOfDayType.day: "assets/lottie/sunny.json",
      TimeOfDayType.night: "assets/lottie/cloudy.json",
    },
  };

  static Map<String, Map<TimeOfDayType, Color>> weatherColors = {
    "Clear": {
      TimeOfDayType.day: const Color(0xFF9DE4F1), // azul cielo
      TimeOfDayType.night: const Color(0xD7224570), // azul muy oscuro
    },
    "Clouds": {
      TimeOfDayType.day: const Color(0xFFB0BEC5), // gris azulado claro
      TimeOfDayType.night: const Color(0xD7224570), // gris oscuro azulado
    },
    "Rain": {
      TimeOfDayType.day: const Color(0xFF90A4AE), // gris azulado medio
      TimeOfDayType.night: const Color(0xD7224570), // gris azulado oscuro
    },
    "Snow": {
      TimeOfDayType.day: const Color(0xFF9AA7B0), // azul muy claro
      TimeOfDayType.night: const Color(0xD7224570), // gris claro frío
    },
    "Thunderstorm": {
      TimeOfDayType.day: const Color(0xFF607D8B), // gris tormentoso
      TimeOfDayType.night: const Color(0xD7224570), // azul profundo
    },
    "Drizzle": {
      TimeOfDayType.day: const Color(0xFF9AA7B0), // gris claro
      TimeOfDayType.night: const Color(0xD7224570), // gris medio oscuro
    },
    "Atmosphere": {
      TimeOfDayType.day: const Color(0xFFE0F7FA), // celeste brumoso
      TimeOfDayType.night: const Color(0xFF263238), // gris azul neblinoso
    },
  };

  static String getWeatherLottie(
      {required String weatherType, required TimeOfDayType time}) {
    return weatherLottie["Thunderstorm"]?[TimeOfDayType.night] ??
        WeatherConstants.loadingLottie;
  }

  static Color getWeatherBackgroundColor(
      {required String weatherType, required TimeOfDayType time}) {
    return weatherColors["Thunderstorm"]?[TimeOfDayType.night] ??
        Colors.white10;
  }
}
