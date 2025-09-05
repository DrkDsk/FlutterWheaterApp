import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/store/cubits/favorite_store_cubit.dart';
import 'package:clima_app/features/favorites/presentation/store/cubits/favorite_store_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowWeatherBottomSheetWidget extends StatefulWidget {
  const ShowWeatherBottomSheetWidget(
      {super.key,
      required this.cityName,
      required this.latitude,
      required this.longitude});

  final String cityName;
  final double latitude;
  final double longitude;

  @override
  State<ShowWeatherBottomSheetWidget> createState() =>
      _ShowWeatherBottomSheetWidgetState();
}

class _ShowWeatherBottomSheetWidgetState
    extends State<ShowWeatherBottomSheetWidget> {
  late FavoriteStoreCubit _favoriteStoreCubit;
  late FavoriteFetchCubit _favoriteFetchCubit;

  @override
  void initState() {
    super.initState();
    _favoriteStoreCubit = context.read<FavoriteStoreCubit>();
    _favoriteFetchCubit = context.read<FavoriteFetchCubit>();
  }

  Future<void> handleSaveCity(
      {required double latitude,
      required double longitude,
      required String cityName,
      required BuildContext context}) async {
    _favoriteStoreCubit.store(
        cityName: cityName, latitude: latitude, longitude: longitude);

    _favoriteFetchCubit.getFavoritesCities();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocSelector<CityWeatherBloc, CityWeatherState, Color?>(
      selector: (state) {
        if (state.status == CityWeatherStatus.success) {
          return state.weatherData?.backgroundColor;
        }

        return WeatherColors.drizzleNight;
      },
      builder: (context, backgroundColor) {
        return BlocListener<FavoriteStoreCubit, FavoriteStoreState>(
          listener: (context, state) {
            if (state.status == FavoriteStoreStatus.success) {
              final router = AppRouter.of(context);

              router.goToScreenAndClear(BlocProvider(
                create: (context) => getIt<CityWeatherBloc>(),
                child: HomeWeatherPage(
                    initialIndex: state.lastCitiStoredIndex ?? 0),
              ));
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.only(
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
                              cityName: widget.cityName,
                              latitude: widget.latitude,
                              longitude: widget.longitude,
                              context: context),
                          child: Text("Agregar",
                              style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                        child: WeatherContentWidget(
                            latitude: widget.latitude,
                            longitude: widget.longitude))
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
