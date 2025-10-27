import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';
import 'package:dartz/dartz.dart';

class FavoriteWeatherRepositoryImpl implements FavoriteWeatherRepository {
  final FavoriteWeatherDataSource _dataSource;
  final LocationService _locationService;

  const FavoriteWeatherRepositoryImpl(
      {required FavoriteWeatherDataSource dataSource,
      required LocationService locationService})
      : _dataSource = dataSource,
        _locationService = locationService;

  @override
  Future<Either<Failure, int>> store({required CityLocation location}) async {
    try {
      final city = CityLocationHiveModel.fromEntity(location);
      final length = await _dataSource.store(city: city);

      return Right(length);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CityLocation>>> fetchAll() async {
    try {
      final models = await _dataSource.fetchAll();

      final storedCities = models.map((city) => city.toEntity()).toList();

      final defaultLocation =
          await _locationService.getCityNameFromCoordinates();

      return Right([defaultLocation, ...storedCities]);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> delete({required String id}) async {
    try {
      await _dataSource.delete(id: id);

      return const Right(null);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }
}
