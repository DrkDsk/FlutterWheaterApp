import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/home/domain/entities/forecast.dart';
import 'package:dartz/dartz.dart';

abstract class SearchWeatherRepository {
  Future<Either<Failure, Forecast>> fetchSearchDataByLocation(
      {required double lat, required double lon});
}
