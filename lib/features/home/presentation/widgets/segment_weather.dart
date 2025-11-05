import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class SegmentWeather extends StatelessWidget {
  const SegmentWeather({
    super.key,
    required this.title,
    required this.emoji,
    required this.value,
    this.backgroundColor,
  });

  final String title;
  final String value;
  final String emoji;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final cardColor = (backgroundColor ?? Colors.grey).customOpacity(0.30);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 25,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w700,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(emoji),
            Text(value),
          ],
        ),
      ),
    );
  }
}
