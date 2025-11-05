import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/presentation/widgets/segment_weather.dart';
import 'package:flutter/material.dart';

class DetailWeatherGrid extends StatelessWidget {
  const DetailWeatherGrid({
    super.key,
    required this.weather,
    this.backgroundColor,
  });

  final Current weather;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SegmentWeather(
          title: "Sensación térmica",
          emoji: "🌡",
          value: weather.feelsLikeCelsiusText,
          backgroundColor: backgroundColor,
        ),
        SegmentWeather(
          title: "Humedad",
          emoji: "💧",
          value: "${weather.humidity}%",
          backgroundColor: backgroundColor,
        ),
        SegmentWeather(
          title: "Viento",
          emoji: "💨",
          value: weather.windDirectionText,
          backgroundColor: backgroundColor,
        ),
        SegmentWeather(
          title: "Índice UV:",
          emoji: "☀️",
          value: "${weather.uvi}",
          backgroundColor: backgroundColor,
        ),
        SegmentWeather(
          title: "Visibilidad",
          emoji: "🌫️",
          value: weather.visibilityTextInKm,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }
}
