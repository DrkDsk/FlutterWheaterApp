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

  Future<Coordinate> ensureCoordinates({
    double? latitude,
    double? longitude,
  }) async {
    if (latitude != null && longitude != null) {
      return Coordinate(
        latitude: latitude,
        longitude: longitude,
      );
    }

    final coordinate = await getCurrentLocation();
    if (coordinate == null) {
      throw UnknownException(
        message: "No se ha podido obtener la ubicación del usuario.",
      );
    }

    return Coordinate(
      latitude: coordinate.latitude,
      longitude: coordinate.longitude,
    );
  }

  Future<CityLocation> getCityNameFromCoordinates(
      {double? latitude, double? longitude}) async {
    final coordinates = await ensureCoordinates(
      latitude: latitude,
      longitude: longitude,
    );

    final placemark = await repository.getLocationInformation(
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
    );

    if (placemark == null) {
      throw UnknownException(
        message: "No se ha podido obtener la información de la ubicación.",
      );
    }

    final city = placemark.locality;
    final state = placemark.administrativeArea;
    final country = placemark.country;
    final cityName = "$city, $state";

    return CityLocation(
      city: "$city",
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      country: country ?? "",
      state: state ?? "",
      cityName: cityName,
    );
  }
}
