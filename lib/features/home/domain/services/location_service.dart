import 'package:clima_app/features/home/domain/entities/location_entity.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';

class LocationService {

  final LocationRepository repository;

  LocationService(this.repository);

  Future<LocationEntity> getCurrentLocation() {
    return repository.getCurrentLocation();
  }

  Future<String?> getCityNameFromCoordinates(double lat, double lng) {
    return repository.getCurrentCityName(latitude: lat, longitude: lng);
  }
}