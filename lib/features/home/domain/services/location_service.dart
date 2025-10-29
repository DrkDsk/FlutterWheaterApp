import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/data/models/location_cache_hive_model.dart';
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
      return Coordinate(latitude: latitude, longitude: longitude);
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

    return CityLocation(
      city: "${placemark.locality}, ${placemark.administrativeArea}",
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      country: placemark.country ?? "",
      state: placemark.administrativeArea ?? "",
    );
  }

  Future<LocationCacheHiveModel?> getLocationCache(
      LocationCacheHiveModel? storedDefaultLocation) async {
    final currentCoordinates = await ensureCoordinates();
    final currentLat = roundCoordinate(currentCoordinates.latitude);
    final currentLon = roundCoordinate(currentCoordinates.longitude);

    final hasStoredLocation = storedDefaultLocation != null;
    final hasMoved = hasStoredLocation &&
        (storedDefaultLocation.latitude != currentLat ||
            storedDefaultLocation.longitude != currentLon);

    if (hasStoredLocation && !hasMoved) {
      return null;
    }

    final currentCityLocation = await getCityNameFromCoordinates();

    return LocationCacheHiveModel.fromEntity(currentCityLocation);
  }

  double roundCoordinate(double value) =>
      double.parse(value.toStringAsFixed(3));
}
