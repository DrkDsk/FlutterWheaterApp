import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/home/presentation/widgets/segment_weather_widget.dart';
import 'package:flutter/material.dart';

class DetailWeatherGridWidget extends StatelessWidget {
  const DetailWeatherGridWidget({
    super.key,
    required this.weatherData,
  });

  final WeatherData weatherData;

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
          value: weatherData.currentWeather.feelsLikeCelsiusText,
        ),
        SegmentWeatherWidget(
          title: "Humedad",
          emoji: "💧",
          value: "${weatherData.currentWeather.humidity}%",
        ),
        SegmentWeatherWidget(
          title: "Viento",
          emoji: "💨",
          value: weatherData.currentWeather.windDirectionText,
        ),
        SegmentWeatherWidget(
          title: "Índice UV:",
          emoji: "☀️",
          value: "${weatherData.currentWeather.uvi}",
        ),
        SegmentWeatherWidget(
          title: "Visibilidad",
          emoji: "🌫️",
          value: weatherData.currentWeather.visibilityTextInKm,
        ),
      ],
    );
  }
}