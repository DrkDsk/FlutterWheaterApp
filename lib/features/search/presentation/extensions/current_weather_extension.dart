import 'package:clima_app/features/search/domain/entities/current.dart';

extension CurrentWeatherExtension on Current {

  double get tempCelsius => (temp ?? 0) - 273.15;

  String get tempCelsiusText => '${tempCelsius.toStringAsFixed(1)}°C';

}