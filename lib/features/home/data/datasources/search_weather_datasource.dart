import 'package:clima_app/features/home/data/models/get_city_weather_response_model.dart';
import 'package:clima_app/features/home/data/models/weather_response_model.dart';

abstract class SearchWeatherDataSource {
  Future<WeatherResponseModel> fetchSearchDataByLocation({required double lat, required double lon});
  Future<GetCityWeatherResponseModel> getCity({required double lat, required double lon});
}