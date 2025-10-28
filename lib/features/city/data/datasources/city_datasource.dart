import 'package:clima_app/features/favorites/data/models/search_city_location_response_model.dart';

abstract class CityDataSource {
  Future<SearchCityLocationResponseModel> searchCity({required String query});
}
