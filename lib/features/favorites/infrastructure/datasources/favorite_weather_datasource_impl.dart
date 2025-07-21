import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:dio/dio.dart';

class FavoriteWeatherDataSourceImpl implements FavoriteWeatherDataSource {

  final Dio dio;

  FavoriteWeatherDataSourceImpl({required this.dio});
}