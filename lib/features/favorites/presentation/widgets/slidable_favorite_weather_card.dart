import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_city_item_card.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableFavoriteWeatherCard extends StatelessWidget {
  const SlidableFavoriteWeatherCard(
      {super.key, required this.currentCity, required this.index});

  final int index;
  final FavoriteLocation currentCity;

  ActionPane buildActionPane({required BuildContext context}) {
    final theme = Theme.of(context);

    return ActionPane(
      extentRatio: 0.35,
      motion: const ScrollMotion(),
      children: [
        CustomSlidableAction(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            onPressed: (context) {
              final currentCityId = currentCity.id;

              if (currentCityId == null || currentCityId.isEmpty) {
                return;
              }

              context
                  .read<FavoriteBloc>()
                  .add(DeleteFavoriteEvent(id: currentCityId));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.delete, size: 30),
                const SizedBox(height: 8),
                Text(
                  "Eliminar",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 24),
                ),
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      direction: Axis.horizontal,
      endActionPane:
          currentCity.id != null ? buildActionPane(context: context) : null,
      child: GestureDetector(
        onTap: () {
          final router = AppRouter.of(context);

          router.goToScreenAndClear(BlocProvider(
            create: (context) => getIt<CityWeatherBloc>(),
            child: HomeWeatherPage(initialIndex: index),
          ));
        },
        child: SavedCityItemCard(cityName: currentCity.cityName),
      ),
    );
  }
}
