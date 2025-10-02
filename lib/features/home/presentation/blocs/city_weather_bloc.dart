import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/city/domain/usecases/get_city_usecase.dart';
import 'package:clima_app/features/city/domain/usecases/search_city_usecase.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final SearchCityUseCase searchCityUseCase;
  final GetWeatherUseCase getWeatherUseCase;
  final GetCityUseCase getCityUseCase;
  final WeatherMapper mapper;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  CityWeatherBloc(
      {required this.getWeatherUseCase,
      required this.searchCityUseCase,
      required this.getCityUseCase,
      required this.mapper})
      : super(const CityWeatherState()) {
    on<FetchWeatherEvent>(_getCurrentWeather);
    on<CitySearchEvent>(_searchWeatherEvent,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<LoadWeatherModalEvent>(_callFetchWeather);
  }

  void _callFetchWeather(
      LoadWeatherModalEvent event, Emitter<CityWeatherState> emit) {
    final String cityName = event.cityName;
    final previousCitySearchResults = state.cities;

    emit(state.copyWith(
        cityName: cityName,
        status: CityWeatherStatus.initial,
        cities: previousCitySearchResults));
  }

  Future<void> _getCurrentWeather(
      FetchWeatherEvent event, Emitter<CityWeatherState> emit) async {
    List<CityLocation>? previousFetchResults = state.cities;

    emit(state.copyWith(status: CityWeatherStatus.loading));

    final latitude = event.latitude;
    final longitude = event.longitude;
    final cityId = event.cityId;

    try {
      final homeWeatherUseCaseResult = await getWeatherUseCase.call(
          latitude: latitude, longitude: longitude);

      final result = homeWeatherUseCaseResult.weatherResponse;
      final cityName = homeWeatherUseCaseResult.cityName;

      final translatedDescription = await mapper.map(
        result.current.weather.first.toEntity(),
      );

      if (emit.isDone) return;

      emit(state.copyWith(status: CityWeatherStatus.initial));

      emit(state.copyWith(
          status: CityWeatherStatus.success,
          cities: previousFetchResults,
          weatherData: WeatherData(
              cityId: cityId,
              currentWeather: result.current,
              hourly: result.hourly ?? [],
              daily: result.daily ?? [],
              city: cityName ?? "",
              translatedWeather: translatedDescription,
              backgroundColor: result.getBackgroundColor(
                  translated: translatedDescription.main))));
    } catch (error) {
      emit(state.copyWith(status: CityWeatherStatus.initial));
      emit(state.copyWith(
          status: CityWeatherStatus.failure, errorMessage: error.toString()));
      return;
    }
  }

  Future<void> _searchWeatherEvent(
      CitySearchEvent event, Emitter<CityWeatherState> emit) async {
    final String query = event.query;

    if (query.isEmpty) {
      emit(state.copyWith(status: CityWeatherStatus.initial, cities: []));
      return;
    }

    final result = await searchCityUseCase.call(query: query);

    result.fold((left) {
      emit(state.copyWith(
          status: CityWeatherStatus.failure, errorMessage: left.message));
    }, (right) {
      final filteredCitySearchResult = right.data.where((element) {
        return element.state != null;
      }).toList();

      emit(state.copyWith(
          status: CityWeatherStatus.initial, cities: filteredCitySearchResult));
    });
  }
}
