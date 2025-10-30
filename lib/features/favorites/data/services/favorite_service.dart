import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/location_cache_hive_model.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';

class FavoriteService {
  final FavoriteWeatherDataSource _favoriteWeatherDataSource;
  final LocationService _locationService;

  const FavoriteService({
    required FavoriteWeatherDataSource favoriteDataSource,
    required LocationService locationService,
  })  : _favoriteWeatherDataSource = favoriteDataSource,
        _locationService = locationService;

  Future<LocationCacheHiveModel> getLocationCache() async {
    final storedLocationCache =
        await _favoriteWeatherDataSource.getStoredLocationCache();

    final currentCoordinates = await _locationService.ensureCoordinates();
    final currentLat = roundCoordinate(currentCoordinates.latitude);
    final currentLon = roundCoordinate(currentCoordinates.longitude);

    final hasStoredLocation = storedLocationCache != null;
    final hasMoved = hasStoredLocation &&
        (storedLocationCache.latitude != currentLat ||
            storedLocationCache.longitude != currentLon);

    if (hasStoredLocation && !hasMoved) {
      return storedLocationCache;
    }

    final currentCityLocation =
        await _locationService.getCityNameFromCoordinates();

    return LocationCacheHiveModel.fromEntity(currentCityLocation);
  }

  double roundCoordinate(double value) =>
      double.parse(value.toStringAsFixed(3));
}
