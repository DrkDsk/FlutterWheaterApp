import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:equatable/equatable.dart';

enum FavoriteFetchStatus { initial, loading, success, failure }

class FavoriteFetchState with EquatableMixin {
  final FavoriteFetchStatus status;
  final List<FavoriteLocation> items;
  final String message;

  const FavoriteFetchState(
      {this.status = FavoriteFetchStatus.initial,
      this.items = const [],
      this.message = ""});

  FavoriteFetchState copyWith({
    FavoriteFetchStatus? status,
    List<FavoriteLocation>? items,
    String? message,
  }) {
    return FavoriteFetchState(
      status: status ?? this.status,
      items: items ?? this.items,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, items, message];
}
