import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/data/services/favorite_service.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteWeatherRepositoryImpl implements FavoriteWeatherRepository {
  final FavoriteWeatherDataSource _favoriteWeatherDataSource;
  final FavoriteService _favoriteService;

  const FavoriteWeatherRepositoryImpl(
      {required FavoriteWeatherDataSource favoriteWeatherDataSource,
      required FavoriteService favoriteService})
      : _favoriteWeatherDataSource = favoriteWeatherDataSource,
        _favoriteService = favoriteService;

  @override
  Future<Either<Failure, bool>> store({required CityLocation location}) async {
    try {
      final currentCityKey = location.key;

      final locationModel = await _favoriteWeatherDataSource.findByKey(
        key: currentCityKey,
      );

      final locationCache =
          await _favoriteWeatherDataSource.getStoredLocationCache();

      if (locationModel != null) {
        return const Right(false);
      }

      final cityModel = CityLocationHiveModel.fromEntity(location);
      await _favoriteWeatherDataSource.store(city: cityModel);

      if (locationCache != null && cityModel.key == locationCache.key) {
        return const Right(false);
      }

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
      final favoritesModels = await _favoriteWeatherDataSource.getAll();
      final storedCities = favoritesModels
          .map(
            (city) => city.toEntity(),
          )
          .toList();

      final storedLocationCache = await _favoriteService.getLocationCache();

      await _favoriteWeatherDataSource.storeLocationCache(
        location: storedLocationCache,
      );

      final cacheIndex = storedCities
          .indexWhere((element) => element.key == storedLocationCache.key);

      if (cacheIndex != -1) {
        storedCities.removeAt(cacheIndex);
      }

      storedCities.insert(0, storedLocationCache.toEntity());

      return Right(storedCities);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> delete(
      {required CityLocation cityLocation}) async {
    try {
      final cityLocationModel =
          await _favoriteWeatherDataSource.findById(id: cityLocation.id);

      if (cityLocationModel == null) {
        return const Right(false);
      }

      await _favoriteWeatherDataSource.delete(model: cityLocationModel);

      return const Right(true);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isAvailableToStore(
      {required CityLocation cityLocation}) async {
    try {
      final cityLocationKey = cityLocation.key;
      final cacheCity =
          await _favoriteWeatherDataSource.getStoredLocationCache();
      final cityAsFavorite = await _favoriteWeatherDataSource.findByKey(
        key: cityLocationKey,
      );

      final cacheCityKey = cacheCity?.key;
      final favoriteCityKey = cityAsFavorite?.key;
      final exists = [cacheCityKey, favoriteCityKey].contains(cityLocationKey);

      return Right(!exists);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }
}
