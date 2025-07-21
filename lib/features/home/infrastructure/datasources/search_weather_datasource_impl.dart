import 'package:clima_app/core/error/exceptions/server_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/extensions/dio/dio_extension.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/home/data/models/weather_response_model.dart';
import 'package:dio/dio.dart';

class SearchWeatherDatasourceImpl implements SearchWeatherDataSource {
  final Dio dio;

  SearchWeatherDatasourceImpl({required this.dio});

  @override
  Future<WeatherResponseModel> fetchSearchDataByLocation({required double lat, required double lon}) async {
    try {
      final response = await dio.get('/data/3.0/onecall?lat=$lat&lon=$lon');

      return WeatherResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(message: e.userFriendlyMessage);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
