import 'package:clima_app/features/favorites/presentation/widgets/saved_city_item_card.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';

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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeWeatherPage())
          ),
          child: SavedCityItemCard(theme: theme),
        );
      },
    );
  }
}