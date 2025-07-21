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
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            isScrollControlled: true,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.90,
              child: Column(
                children: [
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const WeatherItemsList()
                ],
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
