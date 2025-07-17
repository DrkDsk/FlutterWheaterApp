import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/presentation/extensions/daily_presentation.dart';
import 'package:flutter/material.dart';

class DailyListWeatherWidget extends StatelessWidget {
  const DailyListWeatherWidget({
    super.key,
    required this.daily,
  });

  final List<Daily> daily;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: colorScheme.primary.withOpacity(0.4)),
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
                          child: Text(data.diaSemana,
                              style: textTheme.bodyMedium)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.water_drop_outlined,
                                color: colorScheme.onPrimary),
                            Text(data.popPercentageText,
                                style: textTheme.bodySmall),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text("Min: ${data.tempMinCelsiusText}", style: textTheme.bodyMedium),
                          Text("Max: ${data.tempMaxCelsiusText}", style: textTheme.bodyMedium)
                        ],
                      ),
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
