import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
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
    final theme = Theme.of(context);
    return BlocBuilder<CityWeatherBloc, CityWeatherState>(
      builder: (context, state) {
        switch (state.status) {
          case CityWeatherStatus.failure:
            return Text(state.errorMessage, style: theme.textTheme.bodyMedium);
          case CityWeatherStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case CityWeatherStatus.success:
            return CitySearchResultsListWidget(cities: state.cities);
          case CityWeatherStatus.initial:
            return const _FavoritesView();
        }
      },
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteFetchCubit, FavoriteFetchState,
        List<CityLocation>>(
      selector: (state) => state.cities,
      builder: (_, favoritesCities) {
        return SavedFavoriteCitiesListWidget(cities: favoritesCities);
      },
    );
  }
}
