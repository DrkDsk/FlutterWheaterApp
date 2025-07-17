import 'package:clima_app/features/favorites/presentation/blocs/favorite_weather_event.dart';

class SearchFavoriteWeatherEvent extends FavoriteWeatherEvent {
  final String query;

  const SearchFavoriteWeatherEvent({required this.query});
}