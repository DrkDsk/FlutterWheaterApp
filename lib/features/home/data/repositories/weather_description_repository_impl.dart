import 'package:clima_app/features/home/data/datasources/weather_description_local_datasource.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';

import '../../domain/repositories/weather_description_repository.dart';

class WeatherDescriptionRepositoryImpl implements WeatherDescriptionRepository {
  final WeatherDescriptionLocalDataSource dataSource;
  List<TranslatedWeather>? _cache;

  WeatherDescriptionRepositoryImpl({required this.dataSource});

  @override
  Future<TranslatedWeather> getDescription(String code) async {
    _cache ??= await dataSource.loadDescriptions();
    return _cache!
        .firstWhere(
          (desc) => desc.code == code,
          orElse: () => TranslatedWeather(code: code, translatedDescription: ""),
    );
  }
}
