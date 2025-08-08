import 'package:clima_app/core/helpers/injection_helper.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/features/home/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/pages/weather_list_favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({
    super.key,
    this.initialIndex = 0
  });

  final int initialIndex;

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {
  late ThemeCubit _themeCubit;
  late final PageController _pageController;
  late FavoriteBloc _favoriteBloc;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _themeCubit = context.read<ThemeCubit>();
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
    final backgroundWeatherCubit = context.watch<BackgroundWeatherCubit>();
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: BottomAppBarWidget(
        currentPage: _currentPage,
        navigateToFavorites: () => navigateToFavorites(context),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        color: backgroundWeatherCubit.state,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(_themeCubit.state.isDarkMode
                    ? Icons.sunny
                    : Icons.nightlight),
                color: theme.colorScheme.onPrimary,
                onPressed: () => _themeCubit.toggleTheme(),
              ),
              Expanded(
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoritesCitiesState) {
                      final cities = state.cities;

                      if (cities.isNotEmpty) {
                        return PageView.builder(
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
                        );
                      } else {
                        return const WeatherContentWidget();
                      }
                    }

                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
