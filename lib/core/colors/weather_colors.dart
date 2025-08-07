import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:flutter/material.dart';



class WeatherColors {

  static Color clearDay = const Color(0xFFFFA726);
  static Color clearNight = const  Color(0xFF0D47A1);
  static Color cloudDay = const Color(0xFFB0BEC5);
  static Color cloudNight = const Color(0xFF455A64);
  static Color rainDay = const Color(0xFF303F9F);
  static Color rainNight = const Color(0xFF1A237E);
  static Color snowDay = const Color(0xFFE3F2FD);
  static Color snowNight = const Color(0xFF90A4AE);
  static Color thunderstormDay = const Color(0xFF311B92);
  static Color thunderstormNight = const Color(0xFF1A237E);
  static Color drizzleDay = const Color(0xFF78909C);
  static Color drizzleNight = const Color(0xFF546E7A);
  static Color atmosphereDay = const Color(0xFF757575);
  static Color atmosphereNight = const Color(0xFF424242);

  static Map<String, Map<TimeOfDayType, Color>> weatherColors = {
    "Clear": {
      TimeOfDayType.day: clearDay,
      TimeOfDayType.night: clearNight,
    },
    "Clouds": {
      TimeOfDayType.day: cloudDay,
      TimeOfDayType.night: cloudNight,
    },
    "Rain": {
      TimeOfDayType.day: rainDay,
      TimeOfDayType.night: rainNight,
    },
    "Snow": {
      TimeOfDayType.day: snowDay,
      TimeOfDayType.night: snowNight,
    },
    "Thunderstorm": {
      TimeOfDayType.day: thunderstormDay,
      TimeOfDayType.night: thunderstormNight,
    },
    "Drizzle": {
      TimeOfDayType.day: drizzleDay,
      TimeOfDayType.night: drizzleNight,
    },
    "Atmosphere": {
      TimeOfDayType.day: atmosphereDay,
      TimeOfDayType.night: atmosphereNight,
    },
  };

  static Color getWeatherColor(String weatherType, TimeOfDayType time) {
    return weatherColors[weatherType]?[time] ?? Colors.blueGrey;
  }

}