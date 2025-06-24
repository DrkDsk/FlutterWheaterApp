import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/search/data/models/weather_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class SearchWeatherRepository {
  Future<Either<Failure, WeatherResponseModel>> fetchSearchDataByLocation({required double lat, required double lon});
}