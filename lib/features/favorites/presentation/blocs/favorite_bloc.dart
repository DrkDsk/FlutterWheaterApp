import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';
import 'package:uuid/uuid.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteWeatherRepository _repository;
  final LocationService _locationService;

  FavoriteBloc(
      {required FavoriteWeatherRepository repository,
      required LocationService locationService})
      : _repository = repository,
        _locationService = locationService,
        super(const FavoriteLoadingState()) {
    on<StoreCityEvent>(_storeCity);
    on<GetFavoritesCitiesEvent>(_getFavoritesCities);
    on<DeleteFavoriteEvent>(_deleteFavoriteCity);
  }

  Future<void> _storeCity(
      StoreCityEvent event, Emitter<FavoriteState> emit) async {
    final String cityName = event.cityName;
    final double latitude = event.latitude;
    final double longitude = event.longitude;

    final FavoriteLocation location = FavoriteLocation(
        id: const Uuid().v4(),
        cityName: cityName,
        latitude: latitude,
        longitude: longitude);

    final resultEither = await _repository.store(location: location);

    resultEither.fold((error) {
      emit(ErrorFavoriteState(message: error.message));
    }, (result) {
      emit(SuccessFavoriteState(lastCitiStoredIndex: result));
    });
  }

  Future<void> _getFavoritesCities(
      GetFavoritesCitiesEvent event, Emitter<FavoriteState> emit) async {
    final either = await _repository.fetchAll();

    await either.fold((error) {
      emit(ErrorFavoriteState(message: error.message));
    }, (result) async {
      List<FavoriteLocation> cities = [];

      if (result.isEmpty) {
        final coordinate = await _locationService.getCurrentLocation();

        final city = await _locationService.getCityNameFromCoordinates(
            coordinate.latitude, coordinate.longitude);

        final defaultLocation = FavoriteLocation(
            cityName: city ?? "",
            latitude: coordinate.latitude,
            longitude: coordinate.longitude);

        cities.add(defaultLocation);

        emit(FavoritesCitiesState(cities: cities));

        return;
      }

      cities.addAll(result);

      emit(FavoritesCitiesState(cities: cities));
    });
  }

  Future<void> _deleteFavoriteCity(DeleteFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(const FavoriteLoadingState());

    final favoriteId = event.id;

    final deleteEither = await _repository.delete(id: favoriteId);

    deleteEither.fold((left) {

    }, (result) {
    });
  }
}
