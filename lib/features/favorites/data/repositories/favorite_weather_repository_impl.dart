import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';

class FavoriteWeatherRepositoryImpl implements FavoriteWeatherRepository {

  final FavoriteWeatherDataSource dataSource;

  const FavoriteWeatherRepositoryImpl({required this.dataSource});
}