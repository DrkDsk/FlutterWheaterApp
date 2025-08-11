import 'package:clima_app/core/helpers/injection_helper.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_city_item_card.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedFavoriteCitiesListWidget extends StatelessWidget {
  const SavedFavoriteCitiesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoritesCitiesState) {
          final cities = state.cities;
          final citiesLength = cities.length;

          return  ListView.separated(
            itemCount: citiesLength,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              final currentCity = cities[index];

              return GestureDetector(
                onTap: ()  {
                  final router = AppRouter.of(context);

                  router.goToScreenAndClear(
                      BlocProvider(
                        create: (context) => getIt<CityWeatherBloc>(),
                        child: HomeWeatherPage(initialIndex: index),
                      )
                  );
                },
                child: SavedCityItemCard(cityName: currentCity.cityName),
              );
            },
          );
        }

        return const SizedBox.shrink();
      }
    );
  }
}