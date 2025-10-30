import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final Color color;

  const LoadingView({super.key, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
}
