import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/core/extensions/weather/daily_presentation.dart';
import 'package:flutter/material.dart';

class DailyListWeatherWidget extends StatelessWidget {
  const DailyListWeatherWidget(
      {super.key, required this.daily, this.backgroundColor});

  final List<Daily> daily;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconColor = colorScheme.onPrimary;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(color: iconColor);
    final cardColor = (backgroundColor ?? Colors.grey).customOpacity(0.30);

    if (daily.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: cardColor,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...daily.map((data) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        data.diaSemana,
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.thunderstorm,
                            color: WeatherColorConstants.rainDay,
                          ),
                          Text(
                            data.popPercentageText,
                            style: textStyle,
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Min: ${data.tempMinCelsiusText}",
                          style: textStyle,
                        ),
                        Text(
                          "Max: ${data.tempMaxCelsiusText}",
                          style: textStyle,
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
