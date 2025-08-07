import 'package:clima_app/core/helpers/injection_helper.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/pages/weather_list_favorites.dart';
import 'package:flutter/cupertino.dart';
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
  late ThemeCubit themeCubit;
  late final PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    themeCubit = context.read<ThemeCubit>();
    _pageController = PageController(initialPage: widget.initialIndex);
    currentPage = widget.initialIndex;
    final favoriteBloc = context.read<FavoriteBloc>();
    Future.microtask(() {
      favoriteBloc.add(const GetFavoritesCitiesEvent());
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
      bottomNavigationBar: BottomAppBar(
        color: backgroundWeatherCubit.state,
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            const Expanded(child: SizedBox.shrink()),
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                buildWhen: (previous, current) => current is FavoritesCitiesState,
                builder: (context, state) {

                  if (state is FavoritesCitiesState) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.cities.length,
                        itemBuilder: (context, index) {
                          final isActive = currentPage == index;
                          return AnimatedContainer(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              duration: const Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive ? Colors.white : Colors.grey,
                              )
                          );
                        }
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            IconButton(
              color: Colors.white.withOpacity(0.8),
              icon: const Icon(CupertinoIcons.line_horizontal_3),
              onPressed: () => navigateToFavorites(context),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        color: backgroundWeatherCubit.state,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(themeCubit.state.isDarkMode
                    ? Icons.sunny
                    : Icons.nightlight),
                color: theme.colorScheme.onPrimary,
                onPressed: () => themeCubit.toggleTheme(),
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
                              currentPage = value;
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
