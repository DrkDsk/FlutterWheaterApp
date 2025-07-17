import 'package:clima_app/features/search/presentation/blocs/events/favorites/favorite_weather_event.dart';

class SearchFavoriteWeatherEvent extends FavoriteWeatherEvent {
  final String query;

  const SearchFavoriteWeatherEvent({required this.query});
}