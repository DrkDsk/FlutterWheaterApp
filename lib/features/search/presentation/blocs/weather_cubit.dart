import 'package:clima_app/features/search/domain/entities/location.dart';
import 'package:clima_app/features/search/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/search/domain/usecases/get_current_location_usecase.dart';
import 'package:clima_app/features/search/presentation/blocs/state/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {

  final SearchWeatherRepository _repository;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;

  WeatherCubit({required SearchWeatherRepository repository, required GetCurrentLocationUseCase useCase}) : _repository = repository, _getCurrentLocationUseCase = useCase, super(WeatherState(hourly: [], daily: []));

  Future<void> getWeather() async {

    emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.isLoading));

    Location location = await _getCurrentLocationUseCase.call();

    final result = await _repository.fetchSearchDataByLocation(lat: location.latitude, lon: location.longitude);

    result.fold(
      (left) {
        emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.error));
    }, (right) {
        final currentWeather = right.current;
        final hourlyList = right.hourly?.take(12).toList();
        final dailyList = right.daily?.take(7).toList();

        emit(
          state.copyWith(
            currentWeather: currentWeather,
            fetchWeatherStatus: FetchWeatherStatus.success,
            hourly: hourlyList,
            daily:dailyList
          )
        );
    });
  }
}