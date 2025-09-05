import 'package:clima_app/core/shared/ui/widgets/splash_screen.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
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
    Future.microtask(() {
      _favoriteFetchCubit.getFavoritesCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteFetchCubit, FavoriteFetchState>(
        builder: (context, state) {
      if (state.status == FavoriteFetchStatus.loading) {
        return const SplashScreen();
      }

      return const HomeWeatherPage();
    });
  }
}
