import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/usecases/search_city_usecase.dart';
import 'package:clima_app/features/city/presentation/blocs/city_event.dart';
import 'package:clima_app/features/city/presentation/blocs/city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {

  final SearchCityUseCase useCase;

  CityBloc({required this.useCase}) : super(CityInitialState()) {
    on<SearchCityEvent>(_searchWeatherEvent);
    on<SaveFavoriteCityEvent>(_saveFavoriteCity);
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

        emit(SuccessSearchCity(data: filter));
      });
  }

  Future<void> _saveFavoriteCity(SaveFavoriteCityEvent event, Emitter<CityState> emit) async {

    final String cityId = event.cityId;

  }
}
