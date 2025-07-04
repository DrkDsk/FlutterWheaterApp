import 'package:flutter/material.dart';

class HourlyListWeatherWidget extends StatelessWidget {
  const HourlyListWeatherWidget({
    super.key,
    required this.forecastData,
  });

  final List<Map<String, Object>> forecastData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: theme.colorScheme.primary.withOpacity(0.4)
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...forecastData.map((data) {
              return Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Column(
                  children: [
                    Text("${data['hour']}", style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary)),
                    const SizedBox(height: 12),
                    Icon(data['icon'] as IconData, color: colorScheme.onPrimary),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Icon(Icons.water_drop_outlined, color: colorScheme.onPrimary),
                        Text("${data['rain']}", style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Icon(Icons.air, color: colorScheme.onPrimary),
                        Text("${data['wind']}", style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary)),
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
