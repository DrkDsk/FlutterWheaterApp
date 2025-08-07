import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowWeatherBottomSheetWidget extends StatelessWidget {
  const ShowWeatherBottomSheetWidget(
      {super.key,
        required this.latitude,
        required this.longitude,
        required this.onAdd});

  final double latitude;
  final double longitude;
  final Future<void> Function() onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      heightFactor: 0.90,
      child: BlocListener<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is LoadingFavoriteState) {
            showDialog(
                context: context,
                builder: (_) => const CircularProgressIndicator());
          }

          if (state is SuccessFavoriteState) {
            Navigator.pop(context);
            context.read<FavoriteBloc>().add(const GetFavoritesCitiesEvent());
          }

          if (state is FavoritesCitiesState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeWeatherPage()),
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
                    onPressed: () => onAdd(),
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