import 'package:clima_app/core/constants/hive_constants.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';
import 'package:hive/hive.dart';

class FavoriteWeatherDataSourceImpl implements FavoriteWeatherDataSource {
  final Box<FavoriteLocationHiveModel> box;

  FavoriteWeatherDataSourceImpl({required this.box});

  @override
  Future<int> store({required FavoriteLocationHiveModel city}) async {
    try {
      return await box.add(city);
    } catch (e) {
      return -1;
    }
  }

  @override
  Future<List<FavoriteLocationHiveModel>> fetchAll() async {
    final box = await Hive.openBox<FavoriteLocationHiveModel>(citiesBox);

    return box.values.toList();
  }

  @override
  Future<bool> delete({required String id}) async {
    try {
      final item = box.values.where((e) => e.id == id).firstOrNull;

      if (item != null) {
        await item.delete();
      }

      return true;
    } catch (e) {
      throw Exception("");
    }
  }
}