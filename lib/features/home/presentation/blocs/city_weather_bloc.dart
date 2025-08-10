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
    on<CitySelectedEvent>(_getSelectedCity);
  }

  Future<void> _getCurrentWeather(
      FetchWeatherEvent event, Emitter<CityWeatherState> emit) async {
    emit(const WeatherLoadingState());

    final latitude = event.latitude;
    final longitude = event.longitude;
    final cityId = event.cityId;

    final homeWeatherUseCaseResult =
        await getWeatherUseCase.call(latitude: latitude, longitude: longitude);
    final eitherWeather = homeWeatherUseCaseResult.eitherWeather;
    final cityName = homeWeatherUseCaseResult.cityName;

    if (eitherWeather.isLeft()) {
      final error = eitherWeather.swap().getOrElse(() => throw Exception(""));
      emit(WeatherErrorState(message: error.message));
      return;
    }

    final result = eitherWeather.getOrElse(() => throw Exception(""));
    final translatedDescription = await mapper.map(
      result.current.weather.first.toEntity(),
    );

    final hourly = result.hourly?.take(12).toList() ?? [];
    final daily = result.daily?.take(7).toList() ?? [];

    if (emit.isDone) return;

    emit(WeatherSuccessState(
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
      emit(const CityInitialState());
      return;
    }

    final result = await searchCityUseCase.call(query: query);

    result.fold((left) {
      emit(SearchErrorCityState(message: left.message));
    }, (right) {
      final filter = right.data.where((element) {
        return element.state != null;
      }).toList();

      emit(SuccessResultCities(data: filter));
    });
  }

  Future<void> _getSelectedCity(
      CitySelectedEvent event, Emitter<CityWeatherState> emit) async {
    final double latitude = event.latitude;
    final double longitude = event.longitude;

    final result = await getCityUseCase.call(lat: latitude, lon: longitude);

    result.fold((left) {
      emit(SearchErrorCityState(message: left.message));
      return;
    }, (right) {
      final cityId = right.id;

      if (cityId != null) {
        final previousResults = state.previousResults;
        emit(CitySelectedState(
            cityId: cityId,
            longitude: longitude,
            latitude: latitude,
            previousResults: previousResults));
        return;
      }

      emit(const SearchErrorCityState(
          message: "No se ha encontrado información del clima"));
    });
  }
}
