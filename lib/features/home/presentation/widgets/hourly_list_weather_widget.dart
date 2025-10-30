import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/core/extensions/weather/hourly_presentation.dart';
import 'package:flutter/material.dart';

class HourlyListWeatherWidget extends StatelessWidget {
  const HourlyListWeatherWidget({
    super.key,
    required this.hourly,
    this.backgroundColor,
  });

  final List<Hourly> hourly;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconColor = colorScheme.onPrimary;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(color: iconColor);
    final cardColor = (backgroundColor ?? Colors.grey).customOpacity(0.30);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: cardColor,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...hourly.map((data) {
              return Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Column(
                  children: [
                    Text(
                      data.formattedHour,
                      style: textStyle,
                    ),
                    const SizedBox(height: 12),
                    const Icon(
                      Icons.wb_sunny,
                      color: Colors.amber,
                    ),
                    Text(
                      "${data.tempCelsiusText}°",
                      style: textStyle,
                    ),
                    const SizedBox(height: 12),
                    Icon(
                      Icons.thunderstorm,
                      color: WeatherColorConstants.rainDay,
                    ),
                    Text(
                      data.popPercentageText,
                      style: textStyle,
                    ),
                    const SizedBox(height: 12),
                    Icon(
                      Icons.air,
                      color: WeatherColorConstants.cloudDay,
                    ),
                    Text(
                      data.windSpeedKmHText,
                      style: textStyle,
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
