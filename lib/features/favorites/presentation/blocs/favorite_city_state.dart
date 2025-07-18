import 'package:clima_app/features/favorites/domain/entities/city_location_entity.dart';

abstract class FavoriteCityState {
  const FavoriteCityState();
}

final class SearchingFavoriteCityState extends FavoriteCityState {}

final class FavoriteCityInitialState extends FavoriteCityState {}

final class SearchErrorFavoriteCityState extends FavoriteCityState {

  final String message;

  const SearchErrorFavoriteCityState({
    required this.message
  });
}

final class SuccessSearchFavoriteCity extends FavoriteCityState {

  final List<CityLocation> data;

  const SuccessSearchFavoriteCity({required this.data});
}
