import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/home/domain/entities/home_weather_data.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';

class GetWeatherUseCase {
  final SearchWeatherRepository repository;
  final LocationService locationService;
  final WeatherMapper mapper;

  GetWeatherUseCase(
      {required this.locationService,
      required this.repository,
      required this.mapper});

  Future<HomeWeatherData> call({double? latitude, double? longitude}) async {
    final locationEntity = (latitude != null && longitude != null)
        ? Coordinate(latitude: latitude, longitude: longitude)
        : await locationService.getCurrentLocation();

    final forecastEither = await repository.fetchSearchDataByLocation(
      lat: locationEntity.latitude,
      lon: locationEntity.longitude,
    );

    final cityName = await locationService.getCityNameFromCoordinates(
      locationEntity.latitude,
      locationEntity.longitude,
    );

    if (forecastEither.isLeft()) {
      final error = forecastEither.swap().getOrElse(() => throw Exception(""));
      throw GenericFailure(error.message);
    }

    final forecastData =
        forecastEither.getOrElse(() => throw GenericFailure(""));

    final forecast = forecastData.copyWith(
        hourly: forecastData.hourly.take(12).toList(),
        daily: forecastData.daily.take(12).toList());

    final weatherCondition = forecastData.current.weather.first.toEntity();

    final translatedWeather = await mapper.map(weatherCondition);

    return HomeWeatherData(
        forecast: forecast,
        cityName: cityName,
        translatedWeather: translatedWeather);
  }
}
