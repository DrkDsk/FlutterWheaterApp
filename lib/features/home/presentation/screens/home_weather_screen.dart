import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/core/shared/ui/cubits/network_state.dart';
import 'package:clima_app/core/shared/ui/widgets/network_status_builder.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_page_builder.dart';
import 'package:clima_app/features/home/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomeWeatherScreen extends StatefulWidget {
  const HomeWeatherScreen({super.key});

  @override
  State<HomeWeatherScreen> createState() => _HomeWeatherScreenState();
}

class _HomeWeatherScreenState extends State<HomeWeatherScreen> {
  late final PageController _pageController;
  late final HomePageNavigationCubit _homePageNavigationCubit;
  late final FavoriteFetchCubit favoriteFetchCubit;

  @override
  void initState() {
    super.initState();
    _homePageNavigationCubit =
        BlocProvider.of<HomePageNavigationCubit>(context);
    favoriteFetchCubit = BlocProvider.of<FavoriteFetchCubit>(context);
    _pageController =
        PageController(initialPage: _homePageNavigationCubit.state);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, BackgroundWeather>(
      selector: (state) => state.backgroundWeather,
      builder: (context, backgroundWeather) {
        final backgroundColor = backgroundWeather.color;

        return BlocSelector<HomePageNavigationCubit, int, int>(
          selector: (state) => state,
          builder: (context, currentPage) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: backgroundColor,
                    width: double.infinity,
                    height: double.infinity,
                    child: Lottie.asset(
                      backgroundWeather.lottiePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  bottomNavigationBar: BottomAppBarWidget(
                      backgroundColor: backgroundColor,
                      currentPage: currentPage),
                  body: SafeArea(
                    child: BlocConsumer<NetworkCubit, NetworkState>(
                      listenWhen: (prev, current) =>
                          prev.status != current.status,
                      listener: (context, state) {
                        final isConnected =
                            state.status == NetworkStatus.connected;
                        final emptyCities =
                            favoriteFetchCubit.state.cities.isEmpty;

                        if (isConnected && emptyCities) {
                          favoriteFetchCubit.getFavoriteCities();
                        }
                      },
                      buildWhen: (prev, current) =>
                          prev.status != current.status,
                      builder: (context, state) {
                        final isConnected =
                            state.status == NetworkStatus.connected;

                        return Column(
                          children: [
                            if (!isConnected) const NetworkStatusBuilder(),
                            Expanded(
                              child: FavoritesPageBuilder(
                                  initialPage: currentPage),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
