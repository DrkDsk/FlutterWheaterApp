import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  final FavoriteWeatherRepository _repository;
  final LocationService _locationService;

  FavoriteBloc({required FavoriteWeatherRepository repository, required LocationService locationService}) : _repository = repository, _locationService = locationService, super(FavoriteInitial()) {
    on<StoreCityEvent>(_storeCity);
    on<GetFavoritesCitiesEvent>(_getFavoritesCities);
  }

  Future<void> _storeCity(StoreCityEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingFavoriteState());

    final int cityId = event.cityId;
    final double latitude = event.latitude;
    final double longitude = event.longitude;

    final FavoriteLocation location = FavoriteLocation(cityId: cityId, latitude:latitude, longitude: longitude);

    final resultEither = await _repository.storeCity(location: location);

    resultEither.fold(
      (error) {
        emit(ErrorFavoriteState(message: error.message));
      },
      (result) {
        emit(SuccessFavoriteState());
      }
    );
  }

  Future<void> _getFavoritesCities(GetFavoritesCitiesEvent event, Emitter<FavoriteState> emit) async {
    emit(LoadingFavoriteState());

    final either = await _repository.getFavoritesCities();

    await either.fold(
      (error) {
        emit(ErrorFavoriteState(message: error.message));
      }, (result) async {
        List<FavoriteLocation> cities = [];

        if (result.isEmpty) {
          final coordinate = await _locationService.getCurrentLocation();

          final defaultLocation = FavoriteLocation(cityId: 0, latitude: coordinate.latitude, longitude: coordinate.longitude);

          cities.add(defaultLocation);

          emit(FavoritesCitiesState(cities: cities));

          return ;
        }

        cities.addAll(result);

        emit(FavoritesCitiesState(cities: cities));
      }
    );
  }
}
