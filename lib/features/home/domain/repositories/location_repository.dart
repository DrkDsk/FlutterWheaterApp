import 'package:clima_app/features/home/domain/entities/coordinate.dart';

abstract class LocationRepository {
  Future<Coordinate> getCurrentLocation();

  Future<String> getCurrentCityName(
      {required double latitude, required double longitude});
}
