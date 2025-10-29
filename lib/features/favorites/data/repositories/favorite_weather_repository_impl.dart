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
  Future<Either<Failure, bool>> store({required CityLocation location}) async {
    try {
      final models = await _dataSource.fetchAll();
      final city = CityLocationHiveModel.fromEntity(location);
      final storedCitiesFavoritesKey = models.map((element) => element.key);
      final currentCityKey = location.key;
      final storedLocationCache = await _dataSource.getStoredLocationCache();
      final storedCityKey = storedLocationCache?.key;
      final isStored = currentCityKey == storedCityKey ||
          storedCitiesFavoritesKey.contains(currentCityKey);

      if (isStored) {
        return const Right(false);
      }

      await _dataSource.store(city: city);

      return const Right(true);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CityLocation>>> getAll() async {
    try {
      final models = await _dataSource.fetchAll();
      final storedCities = models.map((city) => city.toEntity()).toList();
      final storedLocationCache = await _dataSource.getStoredLocationCache();
      final storedCityKeys = storedCities.map((element) => element.key);
      final storeLocationCacheKey = storedLocationCache?.key;
      final isStored = storedCityKeys.contains(storeLocationCacheKey);

      final updateLocationCache = await _locationService.getLocationCache(
        storedLocationCache,
      );

      if (updateLocationCache != null) {
        await _dataSource.storeLocationCache(location: updateLocationCache);
        storedCities.add(updateLocationCache.toEntity());
      }

      if (storedLocationCache != null && !isStored) {
        storedCities.insert(0, storedLocationCache.toEntity());
      }

      return Right(storedCities);
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
