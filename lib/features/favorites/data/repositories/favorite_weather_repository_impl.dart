import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteWeatherRepositoryImpl implements FavoriteWeatherRepository {
  final FavoriteWeatherDataSource _dataSource;

  const FavoriteWeatherRepositoryImpl(
      {required FavoriteWeatherDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, int>> store({required CityLocation location}) async {
    try {
      final city = CityLocationHiveModel.fromEntity(location);
      final result = await _dataSource.store(city: city);

      return Right(result);
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, List<CityLocation>>> fetchAll() async {
    try {
      final models = await _dataSource.fetchAll();

      return Right(models.map((city) => city.toEntity()).toList());
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, void>> delete({required String id}) async {
    try {
      await _dataSource.delete(id: id);

      return const Right(null);
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
