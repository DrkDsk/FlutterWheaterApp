import 'package:clima_app/core/shared/widgets/splash_screen.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(
    BuildContext context, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {

        if (state is FavoriteLoadingState) {
          return const SplashScreen();
        } else {
          return const HomeWeatherPage();
        }
      }
    );
  }
}
