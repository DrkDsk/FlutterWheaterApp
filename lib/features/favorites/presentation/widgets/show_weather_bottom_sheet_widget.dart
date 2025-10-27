import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/favorites/presentation/store/cubits/favorite_store_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/screens/home_weather_screen.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowWeatherBottomSheetWidget extends StatefulWidget {
  const ShowWeatherBottomSheetWidget({super.key, required this.cityLocation});

  final CityLocation cityLocation;

  @override
  State<ShowWeatherBottomSheetWidget> createState() =>
      _ShowWeatherBottomSheetWidgetState();
}

class _ShowWeatherBottomSheetWidgetState
    extends State<ShowWeatherBottomSheetWidget> {
  late FavoriteStoreCubit _favoriteStoreCubit;
  late FavoriteFetchCubit _favoriteFetchCubit;
  late HomePageNavigationCubit _homePageNavigationCubit;

  @override
  void initState() {
    super.initState();
    _favoriteStoreCubit = context.read<FavoriteStoreCubit>();
    _favoriteFetchCubit = context.read<FavoriteFetchCubit>();
    _homePageNavigationCubit =
        BlocProvider.of<HomePageNavigationCubit>(context);
  }

  Future<void> handleSaveCity(
      {required CityLocation cityLocation,
      required BuildContext context}) async {
    _favoriteStoreCubit.store(cityLocation: cityLocation);
    _favoriteFetchCubit.getFavoriteCities();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocSelector<CityWeatherBloc, CityWeatherState, BackgroundWeather>(
      selector: (state) => state.backgroundWeather,
      builder: (context, backgroundWeather) {
        return BlocListener<FavoriteFetchCubit, FavoriteFetchState>(
          listener: (context, state) {
            if (state.status == FavoriteFetchStatus.success) {
              final router = AppRouter.of(context);
              final pageIndex = state.cities.length - 1;

              _homePageNavigationCubit.updatePageIndex(pageIndex);

              router.goToScreenAndClear(BlocProvider(
                create: (context) => getIt<CityWeatherBloc>(),
                child: const HomeWeatherScreen(),
              ));
            }
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: FractionallySizedBox(
              heightFactor: 0.90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text("Cancelar",
                              style: theme.textTheme.bodyMedium),
                          onPressed: () => AppRouter.of(context).pop(),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => handleSaveCity(
                              cityLocation: widget.cityLocation,
                              context: context),
                          child: Text("Agregar",
                              style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                        child: WeatherContentWidget(
                            latitude: widget.cityLocation.latitude,
                            longitude: widget.cityLocation.longitude))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
