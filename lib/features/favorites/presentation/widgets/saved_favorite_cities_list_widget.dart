import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_city_item_card.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedFavoriteCitiesListWidget extends StatelessWidget {
  const SavedFavoriteCitiesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoritesCitiesState) {
          final favoritesCites = state.cities;
          final citiesLength = favoritesCites.length;

          return  ListView.separated(
            itemCount: citiesLength,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeWeatherPage()),
                  (route) => false,
                ),
                child: SavedCityItemCard(theme: theme),
              );
            },
          );
        }

        return const SizedBox.shrink();
      }
    );
  }
}