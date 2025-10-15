import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/core/shared/ui/cubits/network_state.dart';
import 'package:clima_app/core/shared/ui/widgets/no_connection_widget.dart';
import 'package:clima_app/core/shared/ui/widgets/welcome_screen.dart';
import 'package:clima_app/core/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'App del clima',
      home: BlocBuilder<NetworkCubit, NetworkState>(builder: (context, state) {
        final isOffline = state.status == NetworkStatus.disconnected;

        return Stack(
          children: [
            const WelcomeScreen(),
            if (isOffline) ...[const InternetFailureWidget()]
          ],
        );
      }),
    );
  }
}
