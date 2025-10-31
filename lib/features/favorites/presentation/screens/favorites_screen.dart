import 'package:clima_app/features/favorites/presentation/widgets/favorites_cities_weather_body.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SearchCityHeader(),
              SizedBox(height: 10),
              Expanded(
                child: FavoritesCitiesWeatherBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
