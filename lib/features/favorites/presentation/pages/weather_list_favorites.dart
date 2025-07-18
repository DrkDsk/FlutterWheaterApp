import 'package:clima_app/features/favorites/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_state.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_loading_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_success_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  Future<void> getWeatherSelected(
      {required CityLocation location,
      required BuildContext context}) async {
    final weatherBloc = context.read<WeatherBloc>();
    Future.microtask(() {
      weatherBloc.add(CurrentWeatherEvent(latitude: location.lat, longitude: location.lon));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadingState) {
          showDialog(
              barrierColor: Colors.white12,
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()));
        }

        if (state is WeatherSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeWeatherPage()),
            (route) => false,
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white10,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Weather", style: theme.textTheme.titleSmall),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      onChanged: (value) => context
                          .read<FavoriteCityBloc>()
                          .add(SearchFavoriteCityEvent(query: value)),
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Icon(
                          CupertinoIcons.search,
                          color: CupertinoColors.systemGrey.withOpacity(0.5),
                        ),
                      ),
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          CupertinoIcons.mic,
                          color: CupertinoColors.systemGrey.withOpacity(0.5),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      placeholder: 'Search for a city or a airport',
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
                const SizedBox(height: 20),
                BlocBuilder<FavoriteCityBloc, FavoriteCityState>(
                  builder: (context, state) {
                    if (state is SuccessSearchFavoriteCity) {
                      final result = state.data;
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                const SizedBox(height: 4),
                            separatorBuilder: (context, index) {
                              final currentLocationData = result[index];
                              final cityName = currentLocationData.name;
                              final state = currentLocationData.state;
                              final country = currentLocationData.country;
                              return GestureDetector(
                                onTap: () => getWeatherSelected(
                                    location: currentLocationData,
                                    context: context),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text("$cityName, $state, $country"),
                                ),
                              );
                            },
                            itemCount: result.length),
                      );
                    }

                    if (state is SearchErrorFavoriteCityState) {
                      return Text(state.message,
                          style: theme.textTheme.bodyMedium);
                    }

                    return Expanded(
                      child: ListView.separated(
                        itemCount: 4,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 14);
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => context.read<FavoriteCityBloc>().add(
                                const SaveFavoriteCityEvent(cityId: "Tonalá")),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 18),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Tonalá",
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700)),
                                              const Text("location")
                                            ],
                                          ),
                                        ),
                                        Text("33°",
                                            style: theme.textTheme.titleMedium)
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    const Row(
                                      children: [
                                        Expanded(child: Text("cloudy")),
                                        Row(
                                          children: [Text("H:23° L:24°")],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
