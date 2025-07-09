import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';
import 'package:flutter/material.dart';

class HeaderWeatherWidget extends StatelessWidget {
  const HeaderWeatherWidget({
    super.key,
    required this.temp,
    required this.translatedWeather
  });

  final String temp;
  final TranslatedWeather translatedWeather;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Row(
      children: [
        Image.asset(translatedWeather.getIconAsset()),
        const SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: Text(
            temp,
            style: theme.textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}