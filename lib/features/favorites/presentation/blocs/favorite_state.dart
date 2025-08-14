import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoriteLocationsState {
  final FavoriteStatus status;
  final List<FavoriteLocation> items;
  final String? errorMessage;
  final int? lastCitiStoredIndex;

  const FavoriteLocationsState({
    this.status = FavoriteStatus.initial,
    this.items = const [],
    this.errorMessage,
    this.lastCitiStoredIndex
  });

  FavoriteLocationsState copyWith({
    FavoriteStatus? status,
    List<FavoriteLocation>? items,
    String? errorMessage,
    int? lastCitiStoredIndex
  }) {
    return FavoriteLocationsState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage,
      lastCitiStoredIndex: lastCitiStoredIndex
    );
  }
}
