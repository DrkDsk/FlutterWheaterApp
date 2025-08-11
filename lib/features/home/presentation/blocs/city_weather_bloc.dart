import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/city/domain/usecases/get_city_usecase.dart';
import 'package:clima_app/features/city/domain/usecases/search_city_usecase.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final SearchCityUseCase searchCityUseCase;
  final GetWeatherUseCase getWeatherUseCase;
  final GetCityUseCase getCityUseCase;
  final WeatherMapper mapper;

  CityWeatherBloc(
      {required this.getWeatherUseCase,
      required this.searchCityUseCase,
      required this.getCityUseCase,
      required this.mapper})
      : super(const WeatherInitialState()) {
    on<FetchWeatherEvent>(_getCurrentWeather);
    on<CitySearchEvent>(_searchWeatherEvent);
    on<LoadWeatherModalEvent>(_callFetchWeather);
  }

  void _callFetchWeather(
      LoadWeatherModalEvent event, Emitter<CityWeatherState> emit) {
    final double latitude = event.latitude;
    final double longitude = event.longitude;
    final String cityName = event.cityName;
    final previousCitySearchResults = state.previousCitySearchResults;

    emit(CallWeatherFetchEventState(
        latitude: latitude,
        longitude: longitude,
        cityName: cityName,
        previousCitySearchResults: previousCitySearchResults));
  }

  Future<void> _getCurrentWeather(
      FetchWeatherEvent event, Emitter<CityWeatherState> emit) async {
    List<CityLocation>? previousFetchResults = state.previousCitySearchResults;

    emit(const FetchWeatherLoadingState());

    final latitude = event.latitude;
    final longitude = event.longitude;
    final cityId = event.cityId;

    final homeWeatherUseCaseResult =
        await getWeatherUseCase.call(latitude: latitude, longitude: longitude);
    final eitherWeather = homeWeatherUseCaseResult.eitherWeather;
    final cityName = homeWeatherUseCaseResult.cityName;

    if (eitherWeather.isLeft()) {
      emit(const HideWeatherLoadingState());
      final error = eitherWeather.swap().getOrElse(() => throw Exception(""));
      emit(FetchWeatherErrorState(message: error.message));
      return;
    }

    final result = eitherWeather.getOrElse(() => throw Exception(""));
    final translatedDescription = await mapper.map(
      result.current.weather.first.toEntity(),
    );

    final hourly = result.hourly?.take(12).toList() ?? [];
    final daily = result.daily?.take(7).toList() ?? [];

    if (emit.isDone) return;

    emit(const HideWeatherLoadingState());

    emit(WeatherFetchSuccessState(
        previousCitySearchResults: previousFetchResults,
        weatherData: WeatherStateData(
            cityId: cityId,
            currentWeather: result.current,
            hourly: hourly,
            daily: daily,
            city: cityName ?? "",
            translatedWeather: translatedDescription,
            latitude: latitude,
            longitude: longitude)));
  }

  Future<void> _searchWeatherEvent(
      CitySearchEvent event, Emitter<CityWeatherState> emit) async {
    final String query = event.query;

    if (query.isEmpty) {
      emit(const SearchCityInitialState());
      return;
    }

    final result = await searchCityUseCase.call(query: query);

    result.fold((left) {
      emit(SearchCityErrorState(message: left.message));
    }, (right) {
      final filteredCitySearchResult = right.data.where((element) {
        return element.state != null;
      }).toList();

      emit(SearchCityResultSuccess(citySearchResult: filteredCitySearchResult));
    });
  }
}
