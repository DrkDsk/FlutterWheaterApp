import 'package:clima_app/features/search/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity> getCurrentLocation();
  Future<String?> getCurrentCityName({required double latitude, required double longitude});
}