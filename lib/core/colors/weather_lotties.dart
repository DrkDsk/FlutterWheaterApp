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
      TimeOfDayType.day: const Color(0xFF9DE4F1),
      TimeOfDayType.night: const Color(0xD7224570),
    },
    "Clouds": {
      TimeOfDayType.day: const Color(0xFFB0BEC5),
      TimeOfDayType.night: const Color(0xD7224570),
    },
    "Rain": {
      TimeOfDayType.day: const Color(0xFF90A4AE),
      TimeOfDayType.night: const Color(0xD7224570),
    },
    "Snow": {
      TimeOfDayType.day: const Color(0xFF9AA7B0),
      TimeOfDayType.night: const Color(0xD7224570),
    },
    "Thunderstorm": {
      TimeOfDayType.day: const Color(0xFF607D8B),
      TimeOfDayType.night: const Color(0xD7224570),
    },
    "Drizzle": {
      TimeOfDayType.day: const Color(0xFF9AA7B0),
      TimeOfDayType.night: const Color(0xD7224570),
    },
    "Atmosphere": {
      TimeOfDayType.day: const Color(0xFFE0F7FA),
      TimeOfDayType.night: const Color(0xFF263238),
    },
  };

  static String getWeatherLottie(
      {required String weatherType, required TimeOfDayType time}) {
    return weatherLottie[weatherType]?[time] ?? WeatherConstants.loadingLottie;
  }

  static Color getWeatherBackgroundColor(
      {required String weatherType, required TimeOfDayType time}) {
    return weatherColors[weatherType]?[time] ?? Colors.white10;
  }
}
