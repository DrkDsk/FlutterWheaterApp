import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/city/domain/usecases/get_city_usecase.dart';
import 'package:clima_app/features/city/domain/usecases/search_city_usecase.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final SearchCityUseCase searchCityUseCase;
  final GetWeatherUseCase getWeatherUseCase;
  final GetCityUseCase getCityUseCase;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  CityWeatherBloc(
      {required this.getWeatherUseCase,
      required this.searchCityUseCase,
      required this.getCityUseCase})
      : super(const CityWeatherState()) {
    on<FetchWeatherEvent>(_getCurrentWeather);
    on<CitySearchEvent>(_searchWeatherEvent,
        transformer: debounce(const Duration(milliseconds: 500)));
  }

  Future<void> _getCurrentWeather(
      FetchWeatherEvent event, Emitter<CityWeatherState> emit) async {
    List<CityLocation>? previousFetchResults = state.cities;

    emit(state.copyWith(status: CityWeatherStatus.loading));

    final latitude = event.latitude;
    final longitude = event.longitude;

    try {
      final cityWeatherData = await getWeatherUseCase.call(
          latitude: latitude, longitude: longitude);

      if (emit.isDone) return;

      emit(state.copyWith(status: CityWeatherStatus.initial));

      emit(state.copyWith(
          status: CityWeatherStatus.success,
          cities: previousFetchResults,
          cityWeatherData: cityWeatherData));
    } catch (error) {
      emit(state.copyWith(
          status: CityWeatherStatus.failure, errorMessage: error.toString()));
      return;
    }
  }

  Future<void> _searchWeatherEvent(
      CitySearchEvent event, Emitter<CityWeatherState> emit) async {
    final String query = event.query;

    if (query.isEmpty) {
      emit(state.copyWith(status: CityWeatherStatus.success, cities: []));
      return;
    }

    final result = await searchCityUseCase.call(query: query);

    result.fold((left) {
      emit(state.copyWith(
          status: CityWeatherStatus.failure,
          errorMessage: left.message,
          cities: []));
    }, (right) {
      final filteredCitySearchResult = right.data.where((element) {
        return element.state.isNotEmpty;
      }).toList();

      emit(state.copyWith(
          status: CityWeatherStatus.success, cities: filteredCitySearchResult));
    });
  }
}
