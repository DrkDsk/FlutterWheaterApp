import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';

class LocationService {
  final LocationRepository repository;

  LocationService(this.repository);

  Future<Coordinate?> getCurrentLocation() {
    return repository.getCurrentLocation();
  }

  Future<CityLocation?> getCityNameFromCoordinates(
      {double? latitude, double? longitude}) async {
    if (latitude == null || longitude == null) {
      final coordinate = await getCurrentLocation();

      if (coordinate == null) {
        return null;
      }

      latitude = coordinate.latitude;
      longitude = coordinate.longitude;
    }

    final placemark = await repository.getLocationInformation(
        latitude: latitude, longitude: longitude);

    if (placemark == null) {
      return null;
    }

    final cityName = "${placemark.locality}, ${placemark.administrativeArea}";

    final defaultLocation = CityLocation(
        cityName: cityName,
        latitude: latitude,
        longitude: longitude,
        country: placemark.country ?? "",
        state: placemark.administrativeArea ?? "");

    return defaultLocation;
  }
}
