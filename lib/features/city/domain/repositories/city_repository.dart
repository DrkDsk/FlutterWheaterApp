import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/domain/entities/search_city_location_response.dart';
import 'package:clima_app/features/home/domain/entities/get_city_response.dart';
import 'package:dartz/dartz.dart';

abstract class CityRepository {
  Future<Either<Failure, SearchCityLocationResponse>> searchCity({required String query});
  Future<Either<Failure, GetCityWeatherResponse>> getCity({required double lat, required double lon});
}