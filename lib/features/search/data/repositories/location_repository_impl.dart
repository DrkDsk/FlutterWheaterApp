import 'package:clima_app/features/search/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/search/domain/entities/location_entity.dart';
import 'package:clima_app/features/search/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {

  final LocationDataSourceImpl dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<LocationEntity> getCurrentLocation() {
    return dataSource.getCurrentLocation();
  }
}