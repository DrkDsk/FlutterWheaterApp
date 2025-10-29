import 'package:clima_app/core/constants/hive_constants.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/data/models/location_cache_hive_model.dart';
import 'package:hive/hive.dart';

class FavoriteWeatherDataSourceImpl implements FavoriteWeatherDataSource {
  final Box<CityLocationHiveModel> favoriteCityBox;
  final Box<LocationCacheHiveModel> locationCacheBox;

  FavoriteWeatherDataSourceImpl({
    required this.favoriteCityBox,
    required this.locationCacheBox,
  });

  @override
  Future<void> store({required CityLocationHiveModel city}) async {
    try {
      await favoriteCityBox.add(city);
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<List<CityLocationHiveModel>> getAll() async {
    return favoriteCityBox.values.toList();
  }

  @override
  Future<bool> delete({required String id}) async {
    try {
      final item = favoriteCityBox.values.where((e) => e.id == id).firstOrNull;

      if (item != null) {
        await item.delete();
      }

      return true;
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<LocationCacheHiveModel?> getStoredLocationCache() async {
    final storedDefaultLocation = locationCacheBox.get(locationCacheKey);

    return storedDefaultLocation;
  }

  @override
  Future<void> storeLocationCache({required LocationCacheHiveModel location}) {
    return locationCacheBox.put(locationCacheKey, location);
  }

  @override
  Future<CityLocationHiveModel?> findId({required String id}) async {
    final result = favoriteCityBox.values
        .where((element) => element.key == id)
        .firstOrNull;

    return result;
  }
}
