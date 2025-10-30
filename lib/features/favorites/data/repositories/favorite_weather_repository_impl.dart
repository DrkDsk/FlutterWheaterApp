import 'dart:async';

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
      final (favorites, locationCache) = await (
        _favoriteWeatherDataSource.getAll(),
        _favoriteService.getLocationCache(),
      ).wait;

      final storedCities = favorites.map((city) => city.toEntity()).toList();
      final cachedEntity = locationCache.toEntity();

      unawaited(
        _favoriteWeatherDataSource.storeLocationCache(location: locationCache),
      );

      storedCities
        ..removeWhere((element) => element.key == locationCache.key)
        ..insert(0, cachedEntity);

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

      final results = await Future.wait([
        _favoriteWeatherDataSource.getStoredLocationCache(),
        _favoriteWeatherDataSource.findByKey(key: cityLocationKey),
      ]);

      final cacheCity = results[0];
      final favoriteCity = results[1];

      final exists = cacheCity?.key == cityLocationKey ||
          favoriteCity?.key == cityLocationKey;

      return Right(!exists);
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }
}
