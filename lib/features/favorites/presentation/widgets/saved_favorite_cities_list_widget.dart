import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_event.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_city_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedFavoriteCitiesListWidget extends StatelessWidget {
  const SavedFavoriteCitiesListWidget({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 14);
      },
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.read<FavoriteCityBloc>().add(
              const SaveFavoriteCityEvent(cityId: "Tonalá")),
          child: SavedCityItemCard(theme: theme),
        );
      },
    );
  }
}