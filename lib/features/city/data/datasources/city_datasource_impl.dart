import 'package:clima_app/core/shared/data/datasources/base_datasource.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource.dart';
import 'package:clima_app/features/favorites/data/models/search_city_location_response_model.dart';
import 'package:dio/dio.dart';

class CityDataSourceImpl extends BaseDataSource implements CityDataSource {
  final Dio dio;

  CityDataSourceImpl({required this.dio});

  @override
  Future<SearchCityLocationResponseModel> searchCity({required String query}) {
    return safeRequest(() async {
      const int limit = 5;
      final response = await dio.get('/geo/1.0/direct?q=$query&limit=$limit');

      return SearchCityLocationResponseModel.fromJson(response.data);
    });
  }
}
