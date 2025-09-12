import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_search_results_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_favorite_cities_list_widget.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityResultsContentWidget extends StatelessWidget {
  const CityResultsContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteFetchCubit, FavoriteFetchState,
        List<FavoriteLocation>>(
      selector: (state) => state.items,
      builder: (context, favoritesCities) {
        return BlocBuilder<CityWeatherBloc, CityWeatherState>(
          builder: (context, state) {
            final theme = Theme.of(context);

            final cities = state.cities;

            if (cities.isNotEmpty) {
              return CitySearchResultsListWidget(cities: cities);
            }

            if (state.status == CityWeatherStatus.failure) {
              return Text(state.errorMessage,
                  style: theme.textTheme.bodyMedium);
            }

            return SavedFavoriteCitiesListWidget(cities: favoritesCities);
          },
        );
      },
    );
  }
}
