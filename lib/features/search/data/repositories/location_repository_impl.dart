import 'package:clima_app/features/search/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/search/domain/entities/location.dart';
import 'package:clima_app/features/search/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {

  final LocationDataSourceImpl dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Location> getCurrentLocation() async {
    final position = await dataSource.getCurrentLocation();

    return Location(latitude: position.latitude ?? 0, longitude: position.longitude ?? 0);
  }
}