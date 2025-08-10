import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';

abstract class CityState {
  final List<CityLocation>? previousResults;
  const CityState({this.previousResults});
}

final class LoadingCityState extends CityState {
  const LoadingCityState();
}
