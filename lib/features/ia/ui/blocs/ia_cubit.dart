import 'package:bloc/bloc.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/ia/domain/repositories/ia_repository.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_state.dart';

class IACubit extends Cubit<IAState> {

  final IARepository _repository;

  IACubit({required IARepository repository}) : _repository = repository, super(const IAState());

  Future<void> getRecommendation({
    required WeatherData weatherData
  }) async {

    final temperatureInCelsius = weatherData.currentWeather.tempCelsiusText;
    final feelsLike =  weatherData
        .currentWeather.feelsLikeCelsiusText;
    final humidity = "${weatherData.currentWeather.humidity}%";
    final windSpeedAndGust = weatherData.currentWeather.windDirectionText;
    final condition = weatherData.translatedWeather.translatedDescription;

    emit(state.copyWith(status: IAClientStatus.loading));

    final response = await _repository.getRecommendation(temperatureInCelsius: temperatureInCelsius, feelsLike: feelsLike, humidity: humidity, windSpeedAndGust: windSpeedAndGust, condition: condition);

    emit(state.copyWith(status: IAClientStatus.initial, recommendation: response ?? ""));
  }
}
