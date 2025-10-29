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
      final currentCityKey = location.key;
      final cityStored = await _dataSource.findId(id: currentCityKey);
      final isCityStoredAsFavorite = cityStored != null;
      final storedLocationCache = await _dataSource.getStoredLocationCache();
      final cacheCityKey = storedLocationCache?.key;
      final isStored = currentCityKey == cacheCityKey || isCityStoredAsFavorite;

      if (isStored) {
        return const Right(false);
      }

      final cityModel = CityLocationHiveModel.fromEntity(location);

      await _dataSource.store(city: cityModel);

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
      final models = await _dataSource.getAll();
      final storedCities = models.map((city) => city.toEntity()).toList();
      final storedLocationCache = await _dataSource.getStoredLocationCache();
      final storeLocationCacheKey = storedLocationCache?.key;

      bool? isCityStoredAsFavorite;

      if (storeLocationCacheKey != null) {
        final cityStored = await _dataSource.findId(id: storeLocationCacheKey);
        isCityStoredAsFavorite = cityStored != null;
      }

      final updateLocationCache = await _locationService.getLocationCache(
        storedLocationCache,
      );

      if (updateLocationCache != null) {
        await _dataSource.storeLocationCache(location: updateLocationCache);
        storedCities.add(updateLocationCache.toEntity());
      }

      if (storedLocationCache != null &&
          isCityStoredAsFavorite != null &&
          !isCityStoredAsFavorite) {
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
