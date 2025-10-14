import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:equatable/equatable.dart';

enum FavoriteFetchStatus { initial, loading, success, failure }

class FavoriteFetchState with EquatableMixin {
  final FavoriteFetchStatus status;
  final List<CityLocation> cities;
  final String message;

  const FavoriteFetchState(
      {this.status = FavoriteFetchStatus.initial,
      this.cities = const [],
      this.message = ""});

  FavoriteFetchState copyWith({
    FavoriteFetchStatus? status,
    List<CityLocation>? cities,
    String? message,
  }) {
    return FavoriteFetchState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, cities, message];
}
