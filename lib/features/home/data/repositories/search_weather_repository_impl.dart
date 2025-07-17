import 'package:clima_app/core/error/exceptions/server_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/core/error/failures/server_failure.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/home/domain/entities/weather_response.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchWeatherRepository {
  final SearchWeatherDataSource datasource;

  SearchRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, WeatherResponse>> fetchSearchDataByLocation({required double lat, required double lon}) async {
    try {
      final model = await datasource.fetchSearchDataByLocation(lat: lat, lon: lon);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnknownException {
      return Left(UnexpectedFailure());
    }
  }
}