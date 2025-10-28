import 'package:equatable/equatable.dart';

enum FavoriteStoreStatus { initial, loading, success, failure }

class FavoriteStoreState with EquatableMixin {
  final FavoriteStoreStatus status;
  final String message;

  const FavoriteStoreState({
    this.status = FavoriteStoreStatus.initial,
    this.message = "",
  });

  FavoriteStoreState copyWith({
    FavoriteStoreStatus? status,
    String? message,
  }) {
    return FavoriteStoreState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
