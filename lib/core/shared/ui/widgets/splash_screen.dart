import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieViewer extends StatelessWidget {
  const LottieViewer({
    super.key,
    required this.path,
    required this.backgroundColor,
  });

  final String path;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Lottie.asset(
        path,
        frameRate: FrameRate.max,
        animate: false,
        fit: BoxFit.cover,
      ),
    );
  }
}
