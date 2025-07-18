import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_success_state.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(
    BuildContext context, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeWeatherPage()),
            predicate ?? (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: WeatherColors.cloudDay,
        body: Lottie.asset("assets/lottie/loading_splash.json",
            width: double.infinity, height: double.infinity),
      ),
    );
  }
}
