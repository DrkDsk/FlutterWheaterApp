import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/home/domain/entities/city_weather_data.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:dartz/dartz.dart';

class GetWeatherUseCase {
  final SearchWeatherRepository repository;
  final LocationService locationService;
  final WeatherMapper mapper;

  GetWeatherUseCase({
    required this.locationService,
    required this.repository,
    required this.mapper,
  });

  Future<Either<Failure, CityWeatherData>> call(
      {double? latitude, double? longitude}) async {
    final locationEntity = (latitude != null && longitude != null)
        ? Coordinate(latitude: latitude, longitude: longitude)
        : await locationService.getCurrentLocation();

    if (locationEntity == null) {
      throw UnexpectedFailure();
    }

    final forecastEither = await repository.fetchSearchDataByLocation(
      lat: locationEntity.latitude,
      lon: locationEntity.longitude,
    );

    if (forecastEither.isLeft()) {
      return Left(forecastEither.swap().getOrElse(() => UnexpectedFailure()));
    }

    final forecastData =
        forecastEither.getOrElse(() => throw UnexpectedFailure(""));

    final forecast = forecastData.copyWith(
        hourly: forecastData.hourly.take(12).toList(),
        daily: forecastData.daily.take(12).toList());

    final weatherCondition = forecastData.current.weather.first.toEntity();
    final translatedWeather = await mapper.map(weatherCondition);

    final cityWeatherData = CityWeatherData(
      forecast: forecast,
      translatedWeather: translatedWeather,
    );

    return Right(cityWeatherData);
  }
}
