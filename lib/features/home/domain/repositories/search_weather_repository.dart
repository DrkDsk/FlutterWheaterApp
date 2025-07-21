import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/home/domain/entities/get_city_response.dart';
import 'package:clima_app/features/home/domain/entities/weather_response.dart';
import 'package:dartz/dartz.dart';

abstract class SearchWeatherRepository {
  Future<Either<Failure, WeatherResponse>> fetchSearchDataByLocation({required double lat, required double lon});

  Future<Either<Failure, GetCityWeatherResponse>> getCity({required double lat, required double lon});
}