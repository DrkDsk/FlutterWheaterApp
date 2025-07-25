import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';


class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  final FavoriteWeatherRepository repository;

  FavoriteBloc({required this.repository}) : super(FavoriteInitial()) {
    on<StoreCityEvent>(_storeCity);
  }

  Future<void> _storeCity(StoreCityEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingFavoriteState());

    final int cityId = event.cityId;
    final double latitude = event.latitude;
    final double longitude = event.longitude;

    final FavoriteLocation location = FavoriteLocation(cityId: cityId, latitude:latitude, longitude: longitude);

    final resultEither = await repository.storeCity(location: location);

    resultEither.fold(
        (error) {
          emit(ErrorFavoriteState(message: error.message));
        },
        (result) {
          emit(SuccessFavoriteState());
        }
    );
  }
}
