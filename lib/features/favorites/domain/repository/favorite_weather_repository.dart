import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteWeatherRepository {
  Future<Either<Failure, int>> store({required FavoriteLocation location});
  Future<Either<Failure, List<FavoriteLocation>>> fetchAll();
  Future<Either<Failure, void>> delete({required String id});
}