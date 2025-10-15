import 'package:clima_app/features/favorites/data/models/search_city_location_response_model.dart';
import 'package:clima_app/features/home/data/models/get_city_weather_response_model.dart';

abstract class CityDataSource {
  Future<SearchCityLocationResponseModel> searchCity({required String query});

  Future<GetCityWeatherResponseModel> getCity(
      {required double lat, required double lon});
}
