import 'package:clima_app/features/favorites/domain/entities/city_location_entity.dart';

abstract class CityState {
  const CityState();
}

final class CityInitialState extends CityState {}

final class LoadingCityState extends CityState {}

final class SearchErrorCityState extends CityState {

  final String message;

  const SearchErrorCityState({
    required this.message
  });
}

final class SuccessResultCity extends CityState {

  final List<CityLocation> data;

  const SuccessResultCity({required this.data});
}
