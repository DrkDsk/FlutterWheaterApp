import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_results_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:clima_app/features/favorites/presentation/widgets/show_weather_bottom_sheet_widget.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_loading_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_success_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatefulWidget {
  const WeatherListFavorites({super.key});

  @override
  State<WeatherListFavorites> createState() => _WeatherListFavoritesState();
}

class _WeatherListFavoritesState extends State<WeatherListFavorites> {

  @override
  dispose(){
    super.dispose();
    print("killed");
  }

  Future<void> handleSaveCity(
      {required int cityId,
      required double latitude,
      required double longitude}) async {
    context.read<FavoriteBloc>().add(StoreCityEvent(
        cityId: cityId, latitude: latitude, longitude: longitude));
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadingState) {
          showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()));
        }

        if (state is WeatherSuccessState) {
          final int? cityId = state.weatherData.cityId;
          final double? latitude = state.weatherData.latitude;
          final double? longitude = state.weatherData.longitude;

          Navigator.pop(context);

          if (cityId != null && latitude != null && longitude != null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => ShowWeatherBottomSheetWidget(
                  cityId: cityId,
                  latitude: latitude,
                  longitude: longitude,
                  onAdd: () => handleSaveCity(
                      cityId: cityId,
                      latitude: latitude,
                      longitude: longitude)),
            );
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white10,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Column(
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
      ),
    );
  }
}
