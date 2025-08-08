import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_cities_scroll_indicator_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    super.key,
    required this.currentPage,
    required this.navigateToFavorites
  });

  final int currentPage;
  final void Function()? navigateToFavorites;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      buildWhen: (previous, current) => current is WeatherSuccessState,
      builder: (context, state) {

        if (state is WeatherSuccessState) {
          return BottomAppBar(
            color: state.weatherData.getBackgroundColor(),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                const Expanded(child: SizedBox.shrink()),
                Expanded(
                  child: FavoritesCitiesScrollIndicatorBuilder(
                      currentPage: currentPage),
                ),
                IconButton(
                  color: Colors.white.withOpacity(0.8),
                  icon: const Icon(CupertinoIcons.line_horizontal_3),
                  onPressed: navigateToFavorites,
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();

      },
    );
  }
}