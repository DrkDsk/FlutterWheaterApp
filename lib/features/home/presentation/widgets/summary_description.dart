import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class SummaryDescription extends StatelessWidget {
  const SummaryDescription({
    super.key,
    required this.backgroundColor,
    required this.summaryDescription,
  });

  final Color backgroundColor;
  final String summaryDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: backgroundColor.customOpacity(0.30),
      ),
      child: SingleChildScrollView(
        child: Text(summaryDescription),
      ),
    );
  }
}
