import 'package:clima_app/core/shared/data/datasources/base_datasource.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/home/data/models/forecast_model.dart';
import 'package:dio/dio.dart';

class SearchWeatherDatasourceImpl extends BaseDataSource
    implements SearchWeatherDataSource {
  final Dio dio;

  SearchWeatherDatasourceImpl({required this.dio});

  @override
  Future<ForecastModel> fetchSearchDataByLocation(
      {required double lat, required double lon}) {
    return safeRequest(() async {
      final response = await dio.get('/data/3.0/onecall?lat=$lat&lon=$lon');

      return ForecastModel.fromJson(response.data);
    });
  }
}
