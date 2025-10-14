import 'package:clima_app/core/shared/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:geocoding/geocoding.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSourceImpl dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Coordinate> getCurrentLocation() async {
    final position = await dataSource.getCurrentLocation();

    return Coordinate(
        latitude: position.latitude ?? 0, longitude: position.longitude ?? 0);
  }

  @override
  Future<Placemark?> getLocationInformation(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isEmpty) {
      return null;
    }

    Placemark place = placemarks.first;

    return place;
  }
}
