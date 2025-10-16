import 'package:clima_app/core/shared/ui/widgets/splash_screen.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/presentation/screens/home_weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late FavoriteFetchCubit _favoriteFetchCubit;

  @override
  void initState() {
    super.initState();
    _favoriteFetchCubit = context.read<FavoriteFetchCubit>();
    fetchFavoritesCities();
  }

  void fetchFavoritesCities() {
    Future.microtask(() => _favoriteFetchCubit.getFavoriteCities());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteFetchCubit, FavoriteFetchState>(
        builder: (context, state) {
      if (state.status == FavoriteFetchStatus.success ||
          state.status == FavoriteFetchStatus.failure) {
        return const HomeWeatherScreen();
      }

      return const SplashScreen();
    });
  }
}
