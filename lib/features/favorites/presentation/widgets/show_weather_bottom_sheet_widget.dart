import 'package:clima_app/core/helpers/injection_helper.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowWeatherBottomSheetWidget extends StatelessWidget {
  const ShowWeatherBottomSheetWidget(
      {super.key,
        required this.cityName,
        required this.latitude,
        required this.longitude});

  final String cityName;
  final double latitude;
  final double longitude;

  Future<void> handleSaveCity({
    required double latitude,
    required double longitude,
    required String cityName,
    required BuildContext context
  }) async {
    context.read<FavoriteBloc>().add(
      StoreCityEvent(
        cityName: cityName,
        latitude: latitude,
        longitude: longitude
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      heightFactor: 0.90,
      child: BlocListener<FavoriteBloc, FavoriteState>(
        listener: (context, state) {

          if (state is SuccessFavoriteState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                  BlocProvider(
                    create: (context) => getIt<WeatherBloc>(),
                    child: HomeWeatherPage(initialIndex: state.lastCitiStoredIndex),
                  )
              ),
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child:
                    Text("Cancelar", style: theme.textTheme.bodyMedium),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => handleSaveCity(cityName: cityName, latitude: latitude, longitude: longitude, context: context),
                    child: Text("Agregar", style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Expanded(child: WeatherContentWidget())
            ],
          ),
        ),
      ),
    );
  }
}