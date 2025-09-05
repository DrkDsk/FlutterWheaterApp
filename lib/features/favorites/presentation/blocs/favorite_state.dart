import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';

enum FavoriteStatus { initial, loading, success, failure }

enum FavoriteTypeStatus { stored, fetch, delete }

class FavoriteLocationsState {
  final FavoriteStatus status;
  final FavoriteTypeStatus type;
  final List<FavoriteLocation> items;
  final String errorMessage;
  final int? lastCitiStoredIndex;

  const FavoriteLocationsState(
      {this.status = FavoriteStatus.initial,
      this.type = FavoriteTypeStatus.fetch,
      this.items = const [],
      this.errorMessage = "",
      this.lastCitiStoredIndex});

  FavoriteLocationsState copyWith(
      {FavoriteStatus? status,
      FavoriteTypeStatus? type,
      List<FavoriteLocation>? items,
      String? errorMessage,
      int? lastCitiStoredIndex}) {
    return FavoriteLocationsState(
        status: status ?? this.status,
        type: type ?? this.type,
        items: items ?? this.items,
        errorMessage: errorMessage ?? this.errorMessage,
        lastCitiStoredIndex: lastCitiStoredIndex);
  }
}
