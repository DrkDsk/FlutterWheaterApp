import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';

class LocationService {
  final LocationRepository repository;

  LocationService(this.repository);

  Future<Coordinate> getCurrentLocation() {
    return repository.getCurrentLocation();
  }

  Future<CityLocation?> getCityNameFromCoordinates(
      double lat, double lng) async {
    final placemark =
        await repository.getLocationInformation(latitude: lat, longitude: lng);

    if (placemark == null) {
      return null;
    }

    final cityName = "${placemark.locality}, ${placemark.administrativeArea}";

    final defaultLocation = CityLocation(
        cityName: cityName,
        latitude: lat,
        longitude: lng,
        country: placemark.country ?? "",
        state: placemark.administrativeArea ?? "");

    return defaultLocation;
  }
}
