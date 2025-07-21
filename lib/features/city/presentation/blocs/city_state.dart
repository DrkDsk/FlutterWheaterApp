import 'package:clima_app/features/favorites/domain/entities/city_location_entity.dart';

abstract class CityState {
  final List<CityLocation>? previousResults;
  const CityState({this.previousResults});
}

final class CityInitialState extends CityState {}

final class LoadingCityState extends CityState {}

final class SearchErrorCityState extends CityState {

  final String message;

  const SearchErrorCityState({
    required this.message
  });
}

final class SuccessResultCities extends CityState {

  final List<CityLocation> data;

  const SuccessResultCities({required this.data}) : super(previousResults: data);
}

final class GetSelectedCityWeatherState extends CityState {
  final int? cityId;
  final double latitude;
  final double longitude;

  GetSelectedCityWeatherState({
    required this.cityId,
    required this.latitude,
    required this.longitude,
    List<CityLocation>? previousResults,
  }) : super(previousResults: previousResults ?? []);
}
