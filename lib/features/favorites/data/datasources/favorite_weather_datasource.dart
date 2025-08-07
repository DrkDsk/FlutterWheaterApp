import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';

abstract class FavoriteWeatherDataSource {
  Future<bool> storeCity({required FavoriteLocationHiveModel city});
  Future<List<FavoriteLocationHiveModel>> getFavoriteLocationsModels();
}