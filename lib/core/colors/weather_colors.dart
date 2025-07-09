import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherColors {

  static Color currentWeatherColor(String? key) {
    Map<String,Color> colors = {
      "Thunderstorm" : const Color(0xFF311B92),
      "Drizzle" : const Color(0xFF78909C),
      "Rain" : const Color(0xFF303F9F),
      "Snow" : const Color(0xFFE3F2FD),
      "Atmosphere" : const Color(0xFF757575),
      "Clear" : const Color(0xFFFFA726),
      "Clouds" : const Color(0xFFB0BEC5)
    };

    return colors[key] ?? Colors.white;
  }

}