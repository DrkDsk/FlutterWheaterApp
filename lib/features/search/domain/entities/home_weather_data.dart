import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/search/domain/entities/weather_response.dart';
import 'package:dartz/dartz.dart';

class HomeWeatherData {

  final Either<Failure,WeatherResponse> eitherWeather;
  final String? cityName;

  HomeWeatherData({required this.eitherWeather, required this.cityName});
}