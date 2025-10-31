import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_cities_scroll_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  Future<void> navigateToFavorites(BuildContext context) async {
    final router = AppRouter.of(context);

    router.goToScreenAndClear(
      BlocProvider<CityWeatherBloc>(
        create: (_) => getIt<CityWeatherBloc>(),
        child: const FavoritesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, Color>(
      selector: (state) => state.backgroundWeather.color,
      builder: (context, backgroundColor) {
        return BottomAppBar(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              const Expanded(
                child: SizedBox.shrink(),
              ),
              Expanded(
                child: FavoritesCitiesScrollIndicatorWidget(
                  currentPage: currentPage,
                ),
              ),
              IconButton(
                color: Colors.white.customOpacity(0.8),
                icon: const Icon(CupertinoIcons.line_horizontal_3),
                onPressed: () => navigateToFavorites(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
