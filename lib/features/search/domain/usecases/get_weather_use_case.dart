import 'package:clima_app/features/search/domain/entities/home_weather_data.dart';
import 'package:clima_app/features/search/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/search/domain/services/location_service.dart';

class GetWeatherUseCase {
  final SearchWeatherRepository repository;
  final LocationService locationService;

  GetWeatherUseCase({required this.locationService, required this.repository});

  Future<HomeWeatherData> call() async {
    final location = await locationService.getCurrentLocation();

    final weather = await repository.fetchSearchDataByLocation(
      lat: location.latitude,
      lon: location.longitude,
    );

    final cityName = await locationService.getCityNameFromCoordinates(
      location.latitude,
      location.longitude,
    );

    return HomeWeatherData(
      eitherWeather: weather,
      cityName: cityName,
    );
  }
}
