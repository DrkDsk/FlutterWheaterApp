import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteWeatherRepository {
  Future<Either<Failure, bool>> store({required CityLocation location});

  Future<Either<Failure, List<CityLocation>>> getAll();

  Future<Either<Failure, void>> delete({required String id});
}
