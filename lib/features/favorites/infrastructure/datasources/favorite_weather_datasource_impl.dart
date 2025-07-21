import 'package:clima_app/core/error/exceptions/server_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/extensions/dio/dio_extension.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/search_city_location_response_model.dart';
import 'package:clima_app/features/home/data/models/get_city_weather_response_model.dart';
import 'package:dio/dio.dart';

class FavoriteWeatherDataSourceImpl implements FavoriteWeatherDataSource {

  final Dio dio;

  FavoriteWeatherDataSourceImpl({required this.dio});

  @override
  Future<SearchCityLocationResponseModel> searchCity({required String query}) async {
    try {
      const int limit = 5;
      final response = await dio.get('/geo/1.0/direct?q=$query&limit=$limit');

      return SearchCityLocationResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(message: e.userFriendlyMessage);
    } catch (e) {
      throw UnknownException();
    }
  }
}