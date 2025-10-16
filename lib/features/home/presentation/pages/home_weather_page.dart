import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/core/shared/ui/cubits/network_state.dart';
import 'package:clima_app/core/shared/ui/widgets/no_connection_widget.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/pages/weather_list_favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({super.key});

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {
  late final PageController _pageController;
  late HomePageNavigationCubit _homePageNavigationCubit;

  @override
  void initState() {
    super.initState();
    _homePageNavigationCubit = context.read<HomePageNavigationCubit>();
    _pageController =
        PageController(initialPage: _homePageNavigationCubit.state);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> navigateToFavorites(BuildContext context) async {
    final router = AppRouter.of(context);

    router.goToScreenAndClear(
      BlocProvider<CityWeatherBloc>(
        create: (_) => getIt<CityWeatherBloc>(),
        child: const WeatherListFavorites(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, Color>(
      selector: (state) {
        return state.backgroundColor;
      },
      builder: (context, backgroundColor) {
        return Scaffold(
          backgroundColor: backgroundColor,
          bottomNavigationBar: BlocSelector<HomePageNavigationCubit, int, int>(
            selector: (state) => state,
            builder: (context, currentPageState) {
              return BottomAppBarWidget(
                backgroundColor: backgroundColor,
                currentPage: currentPageState,
                navigateToFavorites: () => navigateToFavorites(context),
              );
            },
          ),
          body: SafeArea(
            child: BlocBuilder<NetworkCubit, NetworkState>(
              builder: (context, state) {
                final isOffline = state.status == NetworkStatus.disconnected;

                return Stack(
                  children: [
                    BlocBuilder<FavoriteFetchCubit, FavoriteFetchState>(
                      builder: (context, state) {
                        final cities = state.cities;

                        return PageView.builder(
                          controller: _pageController,
                          itemCount: cities.length,
                          onPageChanged:
                              _homePageNavigationCubit.updatePageIndex,
                          itemBuilder: (context, index) {
                            final city = cities[index];
                            return WeatherContentWidget(
                              latitude: city.latitude,
                              longitude: city.longitude,
                            );
                          },
                        );
                      },
                    ),
                    if (isOffline) ...[const InternetFailureWidget()]
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
