import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/domain/entities/search_city_location_response.dart';
import 'package:dartz/dartz.dart';

abstract class CityRepository {
  Future<Either<Failure, SearchCityLocationResponse>> searchCity({required String query});
}