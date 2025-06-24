import 'package:clima_app/core/error/exceptions/server_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/core/error/failures/server_failure.dart';
import 'package:clima_app/features/search/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/search/data/models/weather_response_model.dart';
import 'package:clima_app/features/search/domain/repositories/search_weather_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchWeatherRepository {
  final SearchWeatherDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, WeatherResponseModel>> fetchSearchDataByLocation({required double lat, required double lon}) async {
    try {
      final model = await remoteDataSource.fetchSearchDataByLocation(lat: lat, lon: lon);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnknownException {
      return Left(UnexpectedFailure());
    }
  }
}