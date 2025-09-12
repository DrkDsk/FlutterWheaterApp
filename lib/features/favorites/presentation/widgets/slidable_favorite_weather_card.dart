import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/presentation/delete/cubits/favorite_delete_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_city_item_card.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableFavoriteWeatherCard extends StatelessWidget {
  const SlidableFavoriteWeatherCard(
      {super.key, required this.currentCity, required this.index});

  final int index;
  final FavoriteLocation currentCity;

  void deleteFavoriteWeather(BuildContext context) {
    final currentCityId = currentCity.id;

    if (currentCityId == null || currentCityId.isEmpty) {
      return;
    }

    final favoriteDeleteCubit = context.read<FavoriteDeleteCubit>();
    final favoriteFetchCubit = context.read<FavoriteFetchCubit>();

    favoriteDeleteCubit.delete(id: currentCityId);
    favoriteFetchCubit.getFavoritesCities();
  }

  ActionPane buildActionPane({required BuildContext context}) {
    final theme = Theme.of(context);

    return ActionPane(
      extentRatio: 0.35,
      motion: const ScrollMotion(),
      children: [
        CustomSlidableAction(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            onPressed: deleteFavoriteWeather,
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

          BlocProvider.of<HomePageNavigationCubit>(context)
              .updatePageIndex(index);

          router.goToScreenAndClear(BlocProvider(
            create: (context) => getIt<CityWeatherBloc>(),
            child: const HomeWeatherPage(),
          ));
        },
        child: SavedCityItemCard(cityName: currentCity.cityName),
      ),
    );
  }
}
