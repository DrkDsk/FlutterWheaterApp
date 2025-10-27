import 'package:equatable/equatable.dart';

enum FavoriteStoreStatus { initial, loading, success, failure }

class FavoriteStoreState with EquatableMixin {
  final FavoriteStoreStatus status;
  final String message;
  final int lastIndex;

  const FavoriteStoreState({
    this.status = FavoriteStoreStatus.initial,
    this.message = "",
    this.lastIndex = 0,
  });

  FavoriteStoreState copyWith({
    FavoriteStoreStatus? status,
    String? message,
    int? lastIndex,
  }) {
    return FavoriteStoreState(
        status: status ?? this.status,
        message: message ?? this.message,
        lastIndex: lastIndex ?? this.lastIndex);
  }

  @override
  List<Object?> get props => [
        status,
        message,
        lastIndex,
      ];
}
