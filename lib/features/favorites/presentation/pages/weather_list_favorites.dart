import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/core/shared/widgets/alerts.dart';
import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/city/presentation/blocs/city_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_results_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:clima_app/features/favorites/presentation/widgets/show_weather_bottom_sheet_widget.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  void _showWeatherBottomSheet(BuildContext context, WeatherStateData weatherData) {
    final latitude = weatherData.latitude;
    final longitude = weatherData.longitude;

    if (latitude == null || longitude == null) {
      return ;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: weatherData.getBackgroundColor(),
      isScrollControlled: true,
      builder: (context) => ShowWeatherBottomSheetWidget(
        cityName: weatherData.city,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  void _onLoadWeather(BuildContext context, WeatherState state) {
    if (state is WeatherLoadingState) {
      Alerts.showLoadingDialog(context);
    } else if (state is WeatherSuccessState) {
      AppRouter.of(context).pop();
      _showWeatherBottomSheet(context, state.weatherData);
    }
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocListener(
      listeners: [
        BlocListener<CityBloc, CityState>(
          listenWhen: (_, state) => state is CitySelectedState,
          listener: (context, state) {
            final data = state as CitySelectedState;
            context.read<CityWeatherBloc>().add(
              LoadCurrentWeatherForCityEvent(
                cityId: data.cityId,
                latitude: data.latitude,
                longitude: data.longitude,
              ),
            );
          },
        ),
        BlocListener<CityWeatherBloc, WeatherState>(
          listener: _onLoadWeather,
        )
      ],
      child: const Scaffold(
        backgroundColor: Colors.white10,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SearchCityHeader(),
                SizedBox(height: 20),
                Expanded(
                  child: CityResultsContentWidget(),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
