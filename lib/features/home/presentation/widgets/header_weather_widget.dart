import 'package:clima_app/core/extensions/string_extension.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:flutter/material.dart';

class HeaderWeatherWidget extends StatelessWidget {
  const HeaderWeatherWidget({
    super.key,
    required this.temp,
    required this.translatedWeather,
    required this.city
  });

  final String city;
  final String temp;
  final TranslatedWeather translatedWeather;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          city,
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          translatedWeather.translatedDescription.firstUppercase(),
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
    );
  }
}