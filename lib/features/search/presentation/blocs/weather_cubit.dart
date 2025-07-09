import 'package:clima_app/features/search/domain/entities/location_entity.dart';
import 'package:clima_app/features/search/domain/entities/weather_response.dart';
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
      required WeatherMapper mapper})
      : _repository = repository,
        _getCurrentLocationUseCase = useCase,
        _mapper = mapper,
        super(WeatherState(hourly: [], daily: []));

  Future<void> getWeather() async {
    emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.isLoading));

    final location = await _getLocation();
    if (location == null) {
      emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.error));
      return;
    }

    final weatherResult = await _fetchWeather(location);
    if (weatherResult == null) {
      emit(state.copyWith(fetchWeatherStatus: FetchWeatherStatus.error));
      return;
    }

    final city = await _getCityName(location);
    final translatedDescription = await _mapper.map(
      weatherResult.current.weather.first.toEntity(),
    );

    emit(state.copyWith(
      currentWeather: weatherResult.current,
      hourly: weatherResult.hourly?.take(12).toList(),
      daily: weatherResult.daily?.take(7).toList(),
      city: city,
      translatedWeather: translatedDescription,
      fetchWeatherStatus: FetchWeatherStatus.success,
    ));
  }

  Future<LocationEntity?> _getLocation() async {
    try {
      return await _getCurrentLocationUseCase.callToGetCurrentLocation();
    } catch (_) {
      return null;
    }
  }

  Future<WeatherResponse?> _fetchWeather(LocationEntity location) async {
    final result = await _repository.fetchSearchDataByLocation(
      lat: location.latitude,
      lon: location.longitude,
    );
    return result.fold(
      (left) => null,
      (right) => right,
    );
  }

  Future<String?> _getCityName(LocationEntity location) {
    return _getCurrentLocationUseCase.callToGetCity(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }
}
