import 'package:clima_app/features/search/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/search/domain/entities/location_entity.dart';
import 'package:clima_app/features/search/domain/repositories/location_repository.dart';
import 'package:geocoding/geocoding.dart';

class LocationRepositoryImpl implements LocationRepository {

  final LocationDataSourceImpl dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<LocationEntity> getCurrentLocation() async {
    final position = await dataSource.getCurrentLocation();

    return LocationEntity(latitude: position.latitude ?? 0, longitude: position.longitude ?? 0);
  }

  @override
  Future<String?> getCurrentCityName({required double latitude, required double longitude}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isEmpty) {
      return "";
    }

    Placemark place = placemarks.first;

    return "${place.locality}, ${place.administrativeArea}";
  }
}