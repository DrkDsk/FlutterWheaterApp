import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:equatable/equatable.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoriteState with EquatableMixin {
  final FavoriteStatus status;
  final List<CityLocation> cities;
  final String message;

  const FavoriteState(
      {this.status = FavoriteStatus.initial,
      this.cities = const [],
      this.message = ""});

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<CityLocation>? cities,
    String? message,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, cities, message];
}
