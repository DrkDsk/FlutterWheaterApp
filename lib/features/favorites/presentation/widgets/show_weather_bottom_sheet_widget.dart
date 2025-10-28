import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/store/cubits/favorite_store_cubit.dart';
import 'package:clima_app/features/favorites/presentation/store/cubits/favorite_store_state.dart';
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
  late final FavoriteStoreCubit _favoriteStoreCubit;
  late final FavoriteFetchCubit _favoriteFetchCubit;
  late final HomePageNavigationCubit _navigationCubit;

  @override
  void initState() {
    super.initState();
    _favoriteStoreCubit = BlocProvider.of<FavoriteStoreCubit>(context);
    _favoriteFetchCubit = BlocProvider.of<FavoriteFetchCubit>(context);
    _navigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
  }

  void redirectToHome(BuildContext context, FavoriteStoreState state) {
    final router = AppRouter.of(context);

    if (state.status != FavoriteStoreStatus.success) {
      return;
    }

    _favoriteFetchCubit.getFavoriteCities();
    final newIndex = _favoriteFetchCubit.state.cities.length;
    _navigationCubit.updatePageIndex(newIndex);
    router.goToScreenAndClear(const HomeWeatherScreen());
  }

  Future<void> handleSaveCity(
      {required CityLocation cityLocation,
      required BuildContext context}) async {
    _favoriteStoreCubit.store(cityLocation: cityLocation);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, BackgroundWeather>(
      selector: (state) => state.backgroundWeather,
      builder: (context, backgroundWeather) {
        final backgroundColor = backgroundWeather.color;

        return BlocListener<FavoriteStoreCubit, FavoriteStoreState>(
          listener: redirectToHome,
          child: FractionallySizedBox(
            heightFactor: 0.90,
            child: Stack(
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
                      onCancel: () => AppRouter.of(context).pop(),
                      onSave: () => handleSaveCity(
                        cityLocation: widget.cityLocation,
                        context: context,
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
            ),
          ),
        );
      },
    );
  }
}
