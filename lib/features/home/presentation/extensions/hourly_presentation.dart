import 'package:clima_app/features/home/domain/entities/hourly.dart';

extension HourlyPresentation on Hourly {
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch((dt ?? 0) * 1000);

  String get formattedHour =>
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

  double get tempCelsius => (temp ?? 0) - 273.15;

  String get tempCelsiusText => '${tempCelsius.toStringAsFixed(1)}°C';

  int get popPercentage => ((pop ?? 0) * 100).round();

  String get popPercentageText => '$popPercentage%';

  String get windSpeedKmHText => '${((windSpeed ?? 0) * 3.6).toStringAsFixed(1)} km/h';

  String get windDirection {
    final deg = windDeg ?? 0;
    const directions = [
      'N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
      'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW', 'N'
    ];
    final index = ((deg + 11.25) / 22.5).floor();
    return directions[index];
  }
}
