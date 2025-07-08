import 'package:clima_app/features/search/domain/entities/location.dart';
import 'package:clima_app/features/search/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {

  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  Future<Location> call() => repository.getCurrentLocation();
}