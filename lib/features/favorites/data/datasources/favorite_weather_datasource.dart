import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';

abstract class FavoriteWeatherDataSource {
  Future<void> store({required CityLocationHiveModel city});

  Future<List<CityLocationHiveModel>> fetchAll();

  Future<bool> delete({required String id});
}
