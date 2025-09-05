import 'package:equatable/equatable.dart';

enum FavoriteStoreStatus { initial, loading, success, failure }

class FavoriteStoreState with EquatableMixin {
  final FavoriteStoreStatus status;
  final String message;
  final int? lastCitiStoredIndex;

  const FavoriteStoreState(
      {this.status = FavoriteStoreStatus.initial,
      this.message = "",
      this.lastCitiStoredIndex});

  FavoriteStoreState copyWith({
    FavoriteStoreStatus? status,
    String? message,
    int? lastCitiStoredIndex,
  }) {
    return FavoriteStoreState(
      status: status ?? this.status,
      message: message ?? this.message,
      lastCitiStoredIndex: lastCitiStoredIndex ?? this.lastCitiStoredIndex,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
