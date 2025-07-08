import 'package:clima_app/features/search/domain/entities/location_entity.dart';
import 'package:clima_app/features/search/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {

  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  Future<LocationEntity> call() => repository.getCurrentLocation();
}