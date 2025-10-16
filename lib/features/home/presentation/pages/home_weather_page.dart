import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/core/shared/ui/widgets/network_status_builder.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_page_builder.dart';
import 'package:clima_app/features/home/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({super.key});

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {
  late final PageController _pageController;
  late final FavoriteFetchCubit favoriteFetchCubit;
  late final HomePageNavigationCubit _homePageNavigationCubit;

  @override
  void initState() {
    super.initState();
    _homePageNavigationCubit = context.read<HomePageNavigationCubit>();
    favoriteFetchCubit = context.read<FavoriteFetchCubit>();
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
    return BlocSelector<CityWeatherBloc, CityWeatherState, Color>(
      selector: (state) => state.backgroundColor,
      builder: (context, backgroundColor) {
        return BlocSelector<HomePageNavigationCubit, int, int>(
          selector: (state) => state,
          builder: (context, currentPage) {
            return Scaffold(
              backgroundColor: backgroundColor,
              bottomNavigationBar: BottomAppBarWidget(
                  backgroundColor: backgroundColor, currentPage: currentPage),
              body: SafeArea(
                child: Column(
                  children: [
                    const NetworkStatusBuilder(),
                    Expanded(
                        child: FavoritesPageBuilder(initialPage: currentPage)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
