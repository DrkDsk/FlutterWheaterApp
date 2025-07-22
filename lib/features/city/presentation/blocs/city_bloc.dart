import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/usecases/get_city_usecase.dart';
import 'package:clima_app/features/city/domain/usecases/search_city_usecase.dart';
import 'package:clima_app/features/city/presentation/blocs/city_event.dart';
import 'package:clima_app/features/city/presentation/blocs/city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {

  final SearchCityUseCase useCase;
  final GetCityUseCase getCityUseCase;

  CityBloc({required this.useCase, required this.getCityUseCase}) : super(CityInitialState()) {
    on<SearchCityEvent>(_searchWeatherEvent);
    on<SaveFavoriteCityEvent>(_saveFavoriteCity);
    on<GetSelectedCityEvent>(_getSelectedCity);
  }

  Future<void> _searchWeatherEvent(SearchCityEvent event, Emitter<CityState> emit) async {
    final String query = event.query;

    if (query.isEmpty) {
      emit(
        CityInitialState()
      );
      return ;
    }

    final result = await useCase.call(query: query);

    result.fold(
      (left) {
        emit(SearchErrorCityState(message: left.message));
      },
      (right) {
        final filter = right.data.where((element) {
          return element.state != null;
        }).toList();

        emit(SuccessResultCities(data: filter));
      });
  }

  Future<void> _getSelectedCity(
      GetSelectedCityEvent event, Emitter<CityState> emit) async {
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
        emit(GetSelectedCityWeatherState(cityId: cityId, longitude: longitude, latitude: latitude, previousResults: previousResults));
        return ;
      }

      emit(const SearchErrorCityState(message: "No se ha encontrado información del clima"));
    });
  }

  Future<void> _saveFavoriteCity(SaveFavoriteCityEvent event, Emitter<CityState> emit) async {

    final String cityId = event.cityId;

  }
}
