import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/data/models/location_cache_hive_model.dart';

abstract class FavoriteWeatherDataSource {
  Future<CityLocationHiveModel?> findId({required String id});

  Future<void> store({required CityLocationHiveModel city});

  Future<List<CityLocationHiveModel>> getAll();

  Future<bool> delete({required String id});

  Future<LocationCacheHiveModel?> getStoredLocationCache();

  Future<void> storeLocationCache({required LocationCacheHiveModel location});
}
