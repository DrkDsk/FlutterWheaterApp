import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/city/domain/entities/search_city_location_response.dart';
import 'package:clima_app/features/home/domain/entities/get_city_response.dart';
import 'package:dartz/dartz.dart';

class CityRepositoryImpl implements CityRepository {
  final CityDataSource dataSource;

  const CityRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, SearchCityLocationResponse>> searchCity(
      {required String query}) async {
    try {
      final model = await dataSource.searchCity(query: query);
      return Right(model.toEntity());
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, GetCityWeatherResponse>> getCity(
      {required double lat, required double lon}) async {
    try {
      final model = await dataSource.getCity(lat: lat, lon: lon);
      return Right(model.toEntity());
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    } on NetworkException catch (e) {
      return Left(GenericFailure(e.message));
    }
  }
}
