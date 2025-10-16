import 'package:clima_app/core/shared/services/network_service.dart';
import 'package:location/location.dart';

class LocationDataSourceImpl {
  final NetworkService _networkService;

  const LocationDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  Future<LocationData?> getCurrentLocation() async {
    await _networkService.checkConnection();

    final location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    LocationData position = await location.getLocation();

    return position;
  }
}
