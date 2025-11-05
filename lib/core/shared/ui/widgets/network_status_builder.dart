import 'package:clima_app/core/shared/ui/widgets/internet_failure_view.dart';
import 'package:flutter/material.dart';

class NetworkStatusBuilder extends StatelessWidget {
  const NetworkStatusBuilder({super.key, required this.isConnected});

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    if (isConnected) {
      return const SizedBox.shrink();
    }

    return const Padding(
      padding: EdgeInsets.all(4.0),
      child: InternetFailureView(),
    );
  }
}
