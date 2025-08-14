import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';

abstract class FavoriteWeatherDataSource {
  Future<int> store({required FavoriteLocationHiveModel city});
  Future<List<FavoriteLocationHiveModel>> fetchAll();
  Future<bool> delete({required String id});
}