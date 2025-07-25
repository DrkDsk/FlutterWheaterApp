import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/city/presentation/blocs/city_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_search_results_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_favorite_cities_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_loading_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_success_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_items_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  Future<void> handleSaveCity({required int cityId, required double? latitude, required double? longitude}) async {
    
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadingState) {
          showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()));
        }

        if (state is WeatherSuccessState) {
          final int? cityId = state.weatherData.cityId;
          final double? latitude = state.weatherData.latitude;
          final double? longitude = state.weatherData.longitude;

          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    if (cityId != null && latitude != null && longitude != null) ... [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child:
                            Text("Cancelar", style: theme.textTheme.bodyMedium),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child:
                            Text("Agregar", style: theme.textTheme.bodyMedium),
                            onPressed: () => handleSaveCity(cityId: cityId, latitude: latitude, longitude: longitude),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 8),
                    const WeatherItemsList()
                  ],
                ),
              ),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white10,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const SearchCityHeader(),
                const SizedBox(height: 20),
                BlocConsumer<CityBloc, CityState>(
                  listener: (context, state) {
                    if (state is GetSelectedCityWeatherState) {
                      context.read<WeatherBloc>().add(CurrentWeatherEvent(
                          cityId: state.cityId,
                          latitude: state.latitude,
                          longitude: state.longitude));
                    }
                  },
                  builder: (context, state) {
                    final result = state.previousResults;

                    if (result != null) {
                      return Expanded(
                        child:
                            CitySearchResultsListWidget(result: result),
                      );
                    }

                    if (state is SearchErrorCityState) {
                      return Text(state.message,
                          style: theme.textTheme.bodyMedium);
                    }

                    return Expanded(
                      child: SavedFavoriteCitiesListWidget(theme: theme),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
