import 'package:bloc/bloc.dart';
import 'package:clima_app/core/constants/hive_constants.dart';
import 'package:clima_app/features/favorites/data/models/favorite_location_hive_model.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:hive/hive.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  final FavoriteWeatherRepository repository;

  FavoriteBloc({required this.repository}) : super(FavoriteInitial()) {
    on<StoreCityEvent>(_storeCity);
    on<GetFavoritesCitiesEvent>(_getFavoritesCities);
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

  Future<void> _getFavoritesCities(GetFavoritesCitiesEvent event, Emitter<FavoriteState> emit) async {
    final box = await Hive.openBox<FavoriteLocationHiveModel>(citiesBox);

    final List<FavoriteLocation> cities = box.values.toList().map((city) => city.toEntity()).toList();

    emit(GetFavoritesCitiesState(cities: cities));
  }
}
