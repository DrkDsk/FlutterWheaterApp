import 'package:clima_app/features/home/data/models/forecast_model.dart';

abstract interface class SearchWeatherDataSource {
  Future<ForecastModel> fetchSearchDataByLocation({
    required double lat,
    required double lon,
  });
}
