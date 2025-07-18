import 'package:flutter/material.dart';

class SavedCityItemCard extends StatelessWidget {
  const SavedCityItemCard({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 18),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text("Tonalá",
                          style: theme
                              .textTheme.bodyLarge
                              ?.copyWith(
                              fontWeight:
                              FontWeight.w700)),
                      const Text("location")
                    ],
                  ),
                ),
                Text("33°",
                    style: theme.textTheme.titleMedium)
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Expanded(child: Text("cloudy")),
                Row(
                  children: [Text("H:23° L:24°")],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}