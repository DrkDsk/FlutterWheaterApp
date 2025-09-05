import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:equatable/equatable.dart';

enum FavoriteFetchStatus { initial, loading, success, failure }

class FavoriteFetchState with EquatableMixin {
  final FavoriteFetchStatus status;
  final List<FavoriteLocation> items;
  final String message;
  final int? lastCitiStoredIndex;

  const FavoriteFetchState(
      {this.status = FavoriteFetchStatus.initial,
      this.items = const [],
      this.message = "",
      this.lastCitiStoredIndex});

  FavoriteFetchState copyWith({
    FavoriteFetchStatus? status,
    List<FavoriteLocation>? items,
    String? message,
    int? lastCitiStoredIndex,
  }) {
    return FavoriteFetchState(
      status: status ?? this.status,
      items: items ?? this.items,
      message: message ?? this.message,
      lastCitiStoredIndex: lastCitiStoredIndex ?? this.lastCitiStoredIndex,
    );
  }

  @override
  List<Object?> get props => [status, items, message, lastCitiStoredIndex];
}
