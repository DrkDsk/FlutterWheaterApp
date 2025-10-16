import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/core/shared/ui/error_screen.dart';
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
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter(context);
    _favoriteFetchCubit = context.read<FavoriteFetchCubit>();
    fetchFavoritesCities();
  }

  void fetchFavoritesCities() {
    Future.microtask(() {
      _favoriteFetchCubit.getFavoritesCities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteFetchCubit, FavoriteFetchState>(
      listener: (context, state) {
        if (state.status == FavoriteFetchStatus.success) {
          _router.goToScreen(const HomeWeatherPage());
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case FavoriteFetchStatus.initial:
          case FavoriteFetchStatus.success:
          case FavoriteFetchStatus.loading:
            return const SplashScreen();
          case FavoriteFetchStatus.failure:
            return ErrorScreen(
                message: state.message, tryAgainHandler: fetchFavoritesCities);
        }
      },
    );
  }
}
