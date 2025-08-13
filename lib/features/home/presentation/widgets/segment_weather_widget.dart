import 'package:flutter/material.dart';

class SegmentWeatherWidget extends StatelessWidget {
  const SegmentWeatherWidget(
      {super.key, required this.title, required this.emoji, required this.value});

  final String title;
  final String value;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12)),
      child: DefaultTextStyle(
          style: const TextStyle(
              fontSize: 25,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w700
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(emoji),
              Text(value)
            ],
          )
      ),
    );
  }
}