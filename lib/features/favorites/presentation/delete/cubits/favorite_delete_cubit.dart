import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';

import './favorite_delete_state.dart';

class FavoriteDeleteCubit extends Cubit<FavoriteDeleteState> {
  final FavoriteWeatherRepository _repository;

  FavoriteDeleteCubit({required FavoriteWeatherRepository repository})
      : _repository = repository,
        super(const FavoriteDeleteState());

  Future<void> _deleteFavoriteCity({required String id}) async {
    emit(state.copyWith(status: FavoriteDeleteStatus.loading));

    final favoriteId = id;

    final deleteEither = await _repository.delete(id: favoriteId);

    deleteEither.fold((left) {
      emit(state.copyWith(
          status: FavoriteDeleteStatus.failure, message: left.message));
    }, (result) {
      return;
    });
  }
}
