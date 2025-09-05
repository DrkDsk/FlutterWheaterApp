import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';
import 'package:uuid/uuid.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteLocationsState> {
  final FavoriteWeatherRepository _repository;
  final LocationService _locationService;

  FavoriteBloc(
      {required FavoriteWeatherRepository repository,
      required LocationService locationService})
      : _repository = repository,
        _locationService = locationService,
        super(const FavoriteLocationsState()) {
    on<StoreCityEvent>(_storeCity);
    on<GetFavoritesCitiesEvent>(_getFavoritesCities);
    on<DeleteFavoriteEvent>(_deleteFavoriteCity);
  }

  Future<void> _storeCity(
      StoreCityEvent event, Emitter<FavoriteLocationsState> emit) async {
    final String cityName = event.cityName;
    final double latitude = event.latitude;
    final double longitude = event.longitude;

    emit(state.copyWith(
        type: FavoriteTypeStatus.stored, status: FavoriteStatus.initial));

    final FavoriteLocation location = FavoriteLocation(
        id: const Uuid().v4(),
        cityName: cityName,
        latitude: latitude,
        longitude: longitude);

    final resultEither = await _repository.store(location: location);

    resultEither.fold((error) {
      emit(state.copyWith(
          errorMessage: error.message,
          status: FavoriteStatus.failure,
          type: FavoriteTypeStatus.stored));
    }, (result) {
      emit(state.copyWith(
          lastCitiStoredIndex: result,
          status: FavoriteStatus.success,
          type: FavoriteTypeStatus.stored));
    });
  }

  Future<void> _getFavoritesCities(GetFavoritesCitiesEvent event,
      Emitter<FavoriteLocationsState> emit) async {
    final either = await _repository.fetchAll();

    emit(state.copyWith(
        type: FavoriteTypeStatus.fetch, status: FavoriteStatus.initial));

    await either.fold((error) {
      emit(state.copyWith(
        errorMessage: error.message,
        status: FavoriteStatus.failure,
        type: FavoriteTypeStatus.fetch,
      ));
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

        emit(state.copyWith(
          items: cities,
          status: FavoriteStatus.success,
          type: FavoriteTypeStatus.fetch,
        ));

        return;
      }

      cities.addAll(result);

      emit(state.copyWith(
        items: cities,
        status: FavoriteStatus.success,
        type: FavoriteTypeStatus.fetch,
      ));
    });
  }

  Future<void> _deleteFavoriteCity(
      DeleteFavoriteEvent event, Emitter<FavoriteLocationsState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final favoriteId = event.id;

    emit(state.copyWith(
        type: FavoriteTypeStatus.delete, status: FavoriteStatus.initial));

    final deleteEither = await _repository.delete(id: favoriteId);

    deleteEither.fold((left) {
      emit(state.copyWith(
          status: FavoriteStatus.failure,
          errorMessage: left.message,
          type: FavoriteTypeStatus.delete));
    }, (result) {
      add(const GetFavoritesCitiesEvent());
      return;
    });
  }
}
