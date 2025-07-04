import 'package:flutter/material.dart';

class HeaderWeatherWidget extends StatelessWidget {
  const HeaderWeatherWidget({
    super.key,
    required this.temp
  });

  final int temp;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.sunny,
          color: theme.colorScheme.secondary,
          size: 70,
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: Text(
            "$temp °C",
            style: theme.textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}