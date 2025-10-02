import 'package:clima_app/features/home/data/models/forecast_model.dart';

abstract class SearchWeatherDataSource {
  Future<ForecastModel> fetchSearchDataByLocation(
      {required double lat, required double lon});
}
