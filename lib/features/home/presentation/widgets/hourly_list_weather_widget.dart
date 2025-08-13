import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/core/extensions/weather/hourly_presentation.dart';
import 'package:flutter/material.dart';

class HourlyListWeatherWidget extends StatelessWidget {
  const HourlyListWeatherWidget({
    super.key,
    required this.hourly,
  });

  final List<Hourly> hourly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey.withOpacity(0.15)
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
                    Text(data.formattedHour, style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary)),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Icon(Icons.wb_sunny, color: colorScheme.onPrimary),
                        Text("${data.tempCelsiusText}°", style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Icon(Icons.water_drop_outlined, color: colorScheme.onPrimary),
                        Text(data.popPercentageText, style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Icon(Icons.air, color: colorScheme.onPrimary),
                        Text(data.windSpeedKmHText, style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary)),
                      ],
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
