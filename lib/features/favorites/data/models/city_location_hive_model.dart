import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'city_location_hive_model.g.dart';

@HiveType(typeId: 0)
class CityLocationHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String cityName;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final String state;

  @HiveField(5)
  final String country;

  CityLocationHiveModel(
      {required this.id,
      required this.cityName,
      required this.latitude,
      required this.longitude,
      required this.state,
      required this.country});

  CityLocation toEntity() {
    return CityLocation(
        id: id,
        city: cityName,
        latitude: latitude,
        longitude: longitude,
        country: country,
        state: state);
  }

  factory CityLocationHiveModel.fromEntity(CityLocation location) =>
      CityLocationHiveModel(
          id: location.id ?? const Uuid().v4(),
          cityName: location.city,
          latitude: location.latitude,
          longitude: location.longitude,
          state: location.state,
          country: location.country);
}
