import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:hive/hive.dart';

class FavoriteWeatherDataSourceImpl implements FavoriteWeatherDataSource {
  final Box<CityLocationHiveModel> box;

  FavoriteWeatherDataSourceImpl({required this.box});

  @override
  Future<void> store({required CityLocationHiveModel city}) async {
    try {
      await box.add(city);
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<List<CityLocationHiveModel>> fetchAll() async {
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
      throw UnknownException();
    }
  }
}
