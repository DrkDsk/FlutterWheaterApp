import 'package:clima_app/features/home/domain/entities/daily.dart';

extension DailyPresentation on Daily {
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch((dt ?? 0) * 1000);

  String get formattedDate =>
      '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}';

  double get tempMinCelsius => (temperature?.min ?? 0) - 273.15;
  double get tempMaxCelsius => (temperature?.max ?? 0) - 273.15;

  String get tempMinCelsiusText => '${tempMinCelsius.toStringAsFixed(1)}°C';
  String get tempMaxCelsiusText => '${tempMaxCelsius.toStringAsFixed(1)}°C';

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

  String get diaSemana {
    final date = DateTime.fromMillisecondsSinceEpoch((dt ?? 0) * 1000);
    final dias = [
      'Domingo',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
    ];
    return dias[date.weekday % 7]; // weekday va de 1 (Lunes) a 7 (Domingo)
  }
}
