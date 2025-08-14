
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'favorite_location_hive_model.g.dart';

@HiveType(typeId: 0)
class FavoriteLocationHiveModel extends HiveObject {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String cityName;
  
  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  FavoriteLocationHiveModel({
    required this.id,
    required this.cityName,
    required this.latitude,
    required this.longitude
  });

  FavoriteLocation toEntity() => FavoriteLocation(id: id, cityName: cityName, latitude: latitude, longitude: longitude);

  factory FavoriteLocationHiveModel.fromEntity(FavoriteLocation location) =>
      FavoriteLocationHiveModel(id: location.id ?? const Uuid().v4(), cityName: location.cityName, latitude: location.latitude, longitude: location.longitude);
}
