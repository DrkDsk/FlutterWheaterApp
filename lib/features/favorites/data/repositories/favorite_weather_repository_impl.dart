import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteWeatherRepositoryImpl implements FavoriteWeatherRepository {

  final FavoriteWeatherDataSource dataSource;

  const FavoriteWeatherRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, int>> storeCity({required FavoriteLocation location}) async {
    try {
      final city = FavoriteLocationHiveModel.fromEntity(location);
      final result = await dataSource.storeCity(city: city);

      return Right(result);
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, List<FavoriteLocation>>> getFavoritesCities() async {
    try {
      final models = await dataSource.getFavoriteLocationsModels();

      return Right(models.map((city) => city.toEntity()).toList());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}