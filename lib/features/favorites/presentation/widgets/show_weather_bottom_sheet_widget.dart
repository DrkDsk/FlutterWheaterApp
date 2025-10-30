import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/header_weather_sheet.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/screens/home_weather_screen.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ShowWeatherBottomSheetWidget extends StatefulWidget {
  const ShowWeatherBottomSheetWidget({super.key, required this.cityLocation});

  final CityLocation cityLocation;

  @override
  State<ShowWeatherBottomSheetWidget> createState() =>
      _ShowWeatherBottomSheetWidgetState();
}

class _ShowWeatherBottomSheetWidgetState
    extends State<ShowWeatherBottomSheetWidget> {
  late final FavoriteCubit _favoriteCubit;
  late final HomePageNavigationCubit _navigationCubit;

  @override
  void initState() {
    super.initState();
    _favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    _navigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
    Future.microtask(() {
      _favoriteCubit.getCityIsAvailableToSave(
        cityLocation: widget.cityLocation,
      );
    });
  }

  Future<void> redirectToHome(
    BuildContext context,
    FavoriteState state,
  ) async {
    if (state.status != FavoriteStatus.success) {
      return;
    }

    final router = AppRouter.of(context);
    final newIndex = _favoriteCubit.state.cities.length - 1;
    _navigationCubit.updatePageIndex(newIndex);
    router.goToScreenAndClear(HomeWeatherScreen(initialIndex: newIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, BackgroundWeather>(
      selector: (state) => state.backgroundWeather,
      builder: (context, backgroundWeather) {
        final backgroundColor = backgroundWeather.color;

        return BlocListener<FavoriteCubit, FavoriteState>(
          listenWhen: (prev, current) => prev.status != current.status,
          listener: redirectToHome,
          child: FractionallySizedBox(
            heightFactor: 0.90,
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state.status == FavoriteStatus.loading) {
                  return Container(
                    color: backgroundColor,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

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
                    Column(
                      children: [
                        HeaderWeatherSheet(
                          isAbleToSave: state.isAvailableToStore,
                          onCancel: () => AppRouter.of(context).pop(),
                          onSave: () => _favoriteCubit.store(
                            cityLocation: widget.cityLocation,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: WeatherContentWidget(
                            latitude: widget.cityLocation.latitude,
                            longitude: widget.cityLocation.longitude,
                          ),
                        )
                      ],
                    )
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
