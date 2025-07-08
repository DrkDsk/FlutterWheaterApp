import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/search/domain/entities/weather_response.dart';
import 'package:dartz/dartz.dart';

abstract class SearchWeatherRepository {
  Future<Either<Failure, WeatherResponse>> fetchSearchDataByLocation({required double lat, required double lon});
}