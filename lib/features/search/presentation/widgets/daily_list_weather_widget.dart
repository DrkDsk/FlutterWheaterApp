import 'package:flutter/material.dart';

class DailyListWeatherWidget extends StatelessWidget {
  const DailyListWeatherWidget({
    super.key,
    required this.forecastData,
  });

  final List<Map<String, Object>> forecastData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: colorScheme.primary),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...forecastData.map((data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Text("${data['hour']}",
                              style: textTheme.bodyMedium)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.water_drop_outlined,
                                color: colorScheme.onPrimary),
                            Text("${data['rain']}",
                                style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.air, color: colorScheme.onPrimary),
                            Text("${data['wind']}",
                                style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Icon(data['icon'] as IconData, color: colorScheme.onPrimary)),
                      Expanded(child: Text("${data['temp']}°C", style: textTheme.bodyMedium,)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
