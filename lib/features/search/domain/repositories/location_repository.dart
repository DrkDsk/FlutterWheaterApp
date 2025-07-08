import 'package:clima_app/features/search/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Location> getCurrentLocation();
}