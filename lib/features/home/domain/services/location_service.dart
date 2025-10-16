import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';

class LocationService {
  final LocationRepository repository;

  LocationService(this.repository);

  Future<Coordinate?> getCurrentLocation() {
    return repository.getCurrentLocation();
  }

  Future<({double latitude, double longitude})> _ensureCoordinates(
    double? latitude,
    double? longitude,
  ) async {
    if (latitude != null && longitude != null) {
      return (latitude: latitude, longitude: longitude);
    }

    final coordinate = await getCurrentLocation();
    if (coordinate == null) {
      throw UnknownException(
        message: "No se ha podido obtener la ubicación del usuario.",
      );
    }

    return (latitude: coordinate.latitude, longitude: coordinate.longitude);
  }

  Future<CityLocation> getCityNameFromCoordinates(
      {double? latitude, double? longitude}) async {
    final coordinates = await _ensureCoordinates(latitude, longitude);

    final placemark = await repository.getLocationInformation(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
    );

    if (placemark == null) {
      throw UnknownException(
        message: "No se ha podido obtener la información de la ubicación.",
      );
    }

    return CityLocation(
      city: "${placemark.locality}, ${placemark.administrativeArea}",
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      country: placemark.country ?? "",
      state: placemark.administrativeArea ?? "",
    );
  }
}
