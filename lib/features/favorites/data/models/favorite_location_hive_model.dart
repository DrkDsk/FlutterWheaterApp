
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:hive/hive.dart';

part 'favorite_location_hive_model.g.dart';

@HiveType(typeId: 0)
class FavoriteLocationHiveModel extends HiveObject {

  @HiveField(0)
  final int cityId;
  
  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  FavoriteLocationHiveModel({
    required this.cityId,
    required this.latitude,
    required this.longitude
  });

  FavoriteLocation toEntity() => FavoriteLocation(cityId: cityId, latitude: latitude, longitude: longitude);

  factory FavoriteLocationHiveModel.fromEntity(FavoriteLocation location) =>
      FavoriteLocationHiveModel(cityId: location.cityId, latitude: location.latitude, longitude: location.longitude);
}
