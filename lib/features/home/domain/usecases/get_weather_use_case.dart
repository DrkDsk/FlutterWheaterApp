import 'package:clima_app/features/home/domain/entities/home_weather_data.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';

class GetWeatherUseCase {
  final SearchWeatherRepository repository;
  final LocationService locationService;

  GetWeatherUseCase({required this.locationService, required this.repository});

  Future<HomeWeatherData> call({double? latitude, double? longitude}) async {

    final locationEntity = (latitude != null && longitude != null)
        ? Coordinate(latitude: latitude, longitude: longitude)
        : await locationService.getCurrentLocation();

    final weather = await repository.fetchSearchDataByLocation(
      lat: locationEntity.latitude,
      lon: locationEntity.longitude,
    );

    final cityName = await locationService.getCityNameFromCoordinates(
      locationEntity.latitude,
      locationEntity.longitude,
    );

    return HomeWeatherData(
      eitherWeather: weather,
      cityName: cityName,
    );
  }
}
