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

    return BlocBuilder<CityWeatherBloc, CityWeatherState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        final result = state.previousCitySearchResults;

        if (result != null) {
          return CitySearchResultsListWidget(result: result);
        }

        if (state is SearchCityErrorState) {
          return Text(state.message,
              style: theme.textTheme.bodyMedium);
        }

        if (state is WeatherInitialState) {
          return const SavedFavoriteCitiesListWidget();
        }

        return const SizedBox.shrink();
      },
    );
  }
}