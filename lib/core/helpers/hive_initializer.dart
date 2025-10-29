import 'package:clima_app/core/constants/hive_constants.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/data/models/location_cache_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CityLocationHiveModelAdapter());
    Hive.registerAdapter(LocationCacheHiveModelAdapter());
  }

  static Future<Box<CityLocationHiveModel>> getFavoritesCitiesBox() async {
    return await Hive.openBox<CityLocationHiveModel>(citiesBox);
  }

  static Future<Box<LocationCacheHiveModel>> getLocationCacheBox() async {
    return await Hive.openBox<LocationCacheHiveModel>(cacheLocationBox);
  }
}
