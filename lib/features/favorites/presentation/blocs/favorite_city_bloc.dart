import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/usecases/search_favorite_use_case.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_state.dart';

class FavoriteCityBloc extends Bloc<FavoriteCityEvent, FavoriteCityState> {

  final SearchCityUseCase useCase;

  FavoriteCityBloc({required this.useCase}) : super(FavoriteCityInitialState()) {
    on<SearchFavoriteCityEvent>(_searchWeatherEvent);
  }

  Future<void> _searchWeatherEvent(SearchFavoriteCityEvent event, Emitter<FavoriteCityState> emit) async {
    final String query = event.query;

    if (query.isEmpty) {
      emit(
        FavoriteCityInitialState()
      );
      return ;
    }

    final result = await useCase.call(query: query);

    result.fold(
      (left) {
        emit(SearchErrorFavoriteCityState(message: left.message));
      },
      (right) {
        final filter = right.data.where((element) {
          return element.state != null;
        }).toList();

        emit(SuccessSearchFavoriteCity(data: filter));
      });
  }
}
