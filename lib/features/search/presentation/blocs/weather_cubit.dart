import 'package:clima_app/features/search/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/search/presentation/blocs/state/weather_state.dart';
import 'package:clima_app/features/search/presentation/dto/weather_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase useCase;
  final WeatherMapper mapper;

  WeatherCubit({required this.useCase, required this.mapper})
      : super(WeatherState(hourly: [], daily: []));

  Future<void> getWeather() async {
    emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.isLoading));

    final homeWeatherUseCaseResult = await useCase.call();
    final eitherWeather = homeWeatherUseCaseResult.eitherWeather;
    final cityName = homeWeatherUseCaseResult.cityName;

    eitherWeather.fold((left) {
      emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.error));
    }, (result) async {
      final translatedDescription = await mapper.map(
        result.current.weather.first.toEntity(),
      );

      emit(state.copyWith(
        currentWeather: result.current,
        hourly: result.hourly?.take(12).toList(),
        daily: result.daily?.take(7).toList(),
        city: cityName,
        translatedWeather: translatedDescription,
        fetchWeatherStatus: FetchWeatherStatus.success,
      ));
    });
  }
}
