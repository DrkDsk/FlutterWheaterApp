import 'package:clima_app/core/shared/ui/widgets/no_connection_widget.dart';
import 'package:flutter/material.dart';

class NetworkStatusBuilder extends StatelessWidget {
  const NetworkStatusBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: InternetFailureWidget(),
    );
  }
}
