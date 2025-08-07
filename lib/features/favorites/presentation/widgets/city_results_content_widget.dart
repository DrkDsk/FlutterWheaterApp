import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/city/presentation/blocs/city_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_search_results_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_favorite_cities_list_widget.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityResultsContentWidget extends StatelessWidget {
  const CityResultsContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<CityBloc, CityState>(
      listenWhen: (previous, current) => current is CitySelectedState,
      listener: (context, state) {
        final data = state as CitySelectedState;
        context.read<WeatherBloc>().add(LoadCurrentWeatherForCityEvent(
          cityId: data.cityId,
          latitude: data.latitude,
          longitude: data.longitude,
        ));
      },
      builder: (context, state) {
        final result = state.previousResults;

        if (result != null) {
          return CitySearchResultsListWidget(result: result);
        }

        if (state is SearchErrorCityState) {
          return Text(state.message,
              style: theme.textTheme.bodyMedium);
        }

        return const SavedFavoriteCitiesListWidget();
      },
    );
  }
}