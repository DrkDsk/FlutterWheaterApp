import 'package:location/location.dart';
import 'package:clima_app/features/search/domain/entities/location_entity.dart';

class LocationDataSourceImpl {

  Future<LocationEntity> getCurrentLocation() async {

    final location = Location();
    LocationData position = await location.getLocation();

    return LocationEntity(latitude: position.latitude ?? 0, longitude: position.longitude ?? 0);
  }
}