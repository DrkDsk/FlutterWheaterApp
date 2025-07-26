import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {

  static Future<Box<FavoriteLocationHiveModel>> init() async {

    await Hive.initFlutter();

    Hive.registerAdapter(FavoriteLocationHiveModelAdapter());

    return await Hive.openBox<FavoriteLocationHiveModel>('cities');
  }
}