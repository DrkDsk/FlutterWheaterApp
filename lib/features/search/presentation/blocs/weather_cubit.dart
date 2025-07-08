import 'package:clima_app/features/search/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/search/presentation/blocs/state/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {

  final SearchWeatherRepository _repository;

  WeatherCubit({required SearchWeatherRepository repository}) : _repository = repository, super(WeatherState(hourly: []));

  Future<void> getWeather() async {

    emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.isLoading));

    final result = await _repository.fetchSearchDataByLocation(lat: 16.084983, lon: -93.748233);

    result.fold(
      (left) {
        emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.error));
    }, (right) {
        final temp = right.current.temp;
        final humidity = right.current.humidity;
        final hourlyList = right.hourly?.take(10).toList();
        
        emit(
          state.copyWith(
            temp: temp,
            humidity: humidity,
            fetchWeatherStatus: FetchWeatherStatus.success,
            hourly: hourlyList
          )
        );
    });
  }
}