import 'dart:developer';

import 'package:clima_app/features/search/domain/entities/location_entity.dart';
import 'package:clima_app/features/search/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/search/domain/usecases/get_current_location_usecase.dart';
import 'package:clima_app/features/search/presentation/blocs/state/weather_state.dart';
import 'package:clima_app/features/search/presentation/dto/weather_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final SearchWeatherRepository _repository;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final WeatherMapper _mapper;

  WeatherCubit(
      {required SearchWeatherRepository repository,
      required GetCurrentLocationUseCase useCase,
        required WeatherMapper mapper
      })
      : _repository = repository,
        _getCurrentLocationUseCase = useCase,
        _mapper = mapper,
        super(WeatherState(hourly: [], daily: []));

  Future<void> getWeather() async {
    emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.isLoading));

    LocationEntity location =
        await _getCurrentLocationUseCase.callToGetCurrentLocation();
    final double latitude = location.latitude;
    final double longitude = location.longitude;

    final result = await _repository.fetchSearchDataByLocation(
        lat: latitude, lon: longitude);

    result.fold((left) {
      emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.error));
    }, (right) async {
      final currentWeather = right.current;
      final hourlyList = right.hourly?.take(12).toList();
      final dailyList = right.daily?.take(7).toList();
      final String? cityName = await _getCurrentLocationUseCase.callToGetCity(
          latitude: latitude, longitude: longitude);

      final translatedDescription = await _mapper.map(currentWeather.weather.first.toEntity());

      emit(state.copyWith(
        translatedWeather: translatedDescription,
        currentWeather: currentWeather,
        fetchWeatherStatus: FetchWeatherStatus.success,
        hourly: hourlyList,
        daily: dailyList,
        city: cityName,
      ));
    });
  }
}
