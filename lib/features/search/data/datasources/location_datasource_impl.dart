import 'package:location/location.dart';

class LocationDataSourceImpl {

  Future<LocationData> getCurrentLocation() async {

    final location = Location();
    LocationData position = await location.getLocation();

    return position;
  }
}