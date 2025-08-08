import 'package:clima_app/core/helpers/injection_helper.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/core/shared/widgets/splash_screen.dart';
import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/pages/weather_list_favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {
  late final PageController _pageController;
  late FavoriteBloc _favoriteBloc;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentPage = widget.initialIndex;
    _favoriteBloc = context.read<FavoriteBloc>();
    Future.microtask(() {
      _favoriteBloc.add(const GetFavoritesCitiesEvent());
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> navigateToFavorites(BuildContext context) async {
    final router = AppRouter.of(context);

    router.goToScreenAndClear(
      BlocProvider<CityBloc>(
        create: (_) => getIt<CityBloc>(),
        child: const WeatherListFavorites(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, favState) {
        if (favState is FavoritesCitiesState) {
          final cities = favState.cities;

          return BlocSelector<WeatherBloc, WeatherState, Color?>(
            selector: (state) {
              if (state is WeatherSuccessState) {
                return state.weatherData.getBackgroundColor();
              }
              return Colors.white;
            },
            builder: (context, backgroundColor) {
              return Scaffold(
                backgroundColor: backgroundColor,
                bottomNavigationBar: BottomAppBarWidget(
                  currentPage: _currentPage,
                  navigateToFavorites: () => navigateToFavorites(context),
                ),
                body: PageView.builder(
                  controller: _pageController,
                  itemCount: cities.length,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return WeatherContentWidget(
                      latitude: city.latitude,
                      longitude: city.longitude,
                    );
                  },
                ),
              );
            },
          );
        }
        return const SplashScreen();
      },
    );
  }
}
