import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/presentation/widgets/segment_weather_widget.dart';
import 'package:flutter/material.dart';

class DetailWeatherGridWidget extends StatelessWidget {
  const DetailWeatherGridWidget({
    super.key,
    required this.weather,
  });

  final Current weather;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SegmentWeatherWidget(
          title: "Sensación térmica",
          emoji: "🌡",
          value: weather.feelsLikeCelsiusText,
        ),
        SegmentWeatherWidget(
          title: "Humedad",
          emoji: "💧",
          value: "${weather.humidity}%",
        ),
        SegmentWeatherWidget(
          title: "Viento",
          emoji: "💨",
          value: weather.windDirectionText,
        ),
        SegmentWeatherWidget(
          title: "Índice UV:",
          emoji: "☀️",
          value: "${weather.uvi}",
        ),
        SegmentWeatherWidget(
          title: "Visibilidad",
          emoji: "🌫️",
          value: weather.visibilityTextInKm,
        ),
      ],
    );
  }
}
