import 'package:clima_app/core/extensions/string_extension.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:flutter/material.dart';

class HeaderWeatherWidget extends StatelessWidget {
  const HeaderWeatherWidget({
    super.key,
    required this.temp,
    required this.translatedWeather,
    required this.cityName,
  });

  final String cityName;
  final String temp;
  final TranslatedWeather translatedWeather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cityName,
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Text(
            translatedWeather.translatedDescription.firstUppercaseAll(),
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 26),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(translatedWeather.getIconAsset()),
              Text(
                temp,
                style: theme.textTheme.titleLarge,
              )
            ],
          ),
        ],
      ),
    );
  }
}
