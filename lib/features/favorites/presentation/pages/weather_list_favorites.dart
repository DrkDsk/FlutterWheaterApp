import 'package:clima_app/features/favorites/presentation/blocs/favorite_weather_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/search_favority_weather_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
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
              Expanded(
                child: SizedBox(
                  child: ListView.separated(
                    itemCount: 4,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 14);
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => context.read<FavoriteWeatherBloc>().add(const SearchFavoriteWeatherEvent(query: "Tonalá")),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
