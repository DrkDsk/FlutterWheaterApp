import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';

class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState({required this.message});
}