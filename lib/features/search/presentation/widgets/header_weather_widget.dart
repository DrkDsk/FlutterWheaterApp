import 'package:flutter/material.dart';

class HeaderWeatherWidget extends StatelessWidget {
  const HeaderWeatherWidget({
    super.key,
    required this.temp
  });

  final String temp;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Row(
      children: [
        const Icon(
          Icons.sunny,
          color: Colors.amberAccent,
          size: 70,
        ),
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