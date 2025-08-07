import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteWeatherRepository {
  Future<Either<Failure, bool>> storeCity({required FavoriteLocation location});
  Future<Either<Failure, List<FavoriteLocation>>> getFavoritesCities();
}