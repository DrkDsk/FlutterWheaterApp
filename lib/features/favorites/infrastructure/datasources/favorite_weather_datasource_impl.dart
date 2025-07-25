import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';
import 'package:hive/hive.dart';

class FavoriteWeatherDataSourceImpl implements FavoriteWeatherDataSource {
  final Box<FavoriteLocationHiveModel> box;

  FavoriteWeatherDataSourceImpl({required this.box});

  @override
  Future<bool> storeCity({required FavoriteLocationHiveModel city}) async {
    try {
      await box.add(city);
      return true;
    } catch (e) {
      return false;
    }
  }
}