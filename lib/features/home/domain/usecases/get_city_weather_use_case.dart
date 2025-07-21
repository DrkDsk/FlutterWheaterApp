import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/features/home/data/repositories/search_weather_repository_impl.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/home/infrastructure/datasources/search_weather_datasource_impl.dart';

class GetCityWeatherUseCase {

  late SearchWeatherRepository repository;

  GetCityWeatherUseCase() {
    repository = SearchWeatherRepositoryImpl(
      datasource: SearchWeatherDatasourceImpl(dio: DioClient().dio)
    );
  }
}