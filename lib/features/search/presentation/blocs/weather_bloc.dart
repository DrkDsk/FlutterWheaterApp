import 'package:clima_app/features/search/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/search/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/search/presentation/blocs/states/weather_error_state.dart';
import 'package:clima_app/features/search/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/search/presentation/blocs/states/weather_loading_state.dart';
import 'package:clima_app/features/search/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/search/presentation/blocs/states/weather_success_state.dart';
import 'package:clima_app/features/search/presentation/dto/weather_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase useCase;
  final WeatherMapper mapper;

  WeatherBloc({required this.useCase, required this.mapper})
      : super(const WeatherLoadingState()) {
    on<CurrentWeatherEvent>(_getCurrentWeather);
  }

  Future<void> _getCurrentWeather(
      CurrentWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoadingState());

    final homeWeatherUseCaseResult = await useCase.call();
    final eitherWeather = homeWeatherUseCaseResult.eitherWeather;
    final cityName = homeWeatherUseCaseResult.cityName;

    if (eitherWeather.isLeft()) {
      final error = eitherWeather.swap().getOrElse(() => throw Exception(""));
      emit(WeatherErrorState(message: error.message));
      return ;
    }

    final result = eitherWeather.getOrElse(() => throw Exception(""));
    final translatedDescription = await mapper.map(
      result.current.weather.first.toEntity(),
    );

    final hourly = result.hourly?.take(12).toList() ?? [];
    final daily = result.daily?.take(7).toList() ?? [];

    if (emit.isDone) return;

    emit(
        WeatherSuccessState(
          weatherData: WeatherStateData(
              currentWeather: result.current,
              hourly: hourly,
              daily: daily,
              city: cityName ?? "",
              translatedWeather: translatedDescription
          )
        )
    );
  }
}
