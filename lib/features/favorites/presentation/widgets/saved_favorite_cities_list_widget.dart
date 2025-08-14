import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/slidable_favorite_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedFavoriteCitiesListWidget extends StatelessWidget {
  const SavedFavoriteCitiesListWidget({
    super.key,
    required this.cities
  });

  final List<FavoriteLocation> cities;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoritesCitiesState) {
          final citiesLength = cities.length;

          return ListView.separated(
            itemCount: citiesLength,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              final currentCity = cities[index];

              return SlidableFavoriteWeatherCard(currentCity: currentCity, index: index);
            },
          );
        }

        return const SizedBox.shrink();
      }
    );
  }
}