import 'package:equatable/equatable.dart';

enum FavoriteDeleteStatus { initial, loading, success, failure }

class FavoriteDeleteState with EquatableMixin {
  final FavoriteDeleteStatus status;
  final String message;

  const FavoriteDeleteState(
      {this.status = FavoriteDeleteStatus.initial, this.message = ""});

  FavoriteDeleteState copyWith({
    FavoriteDeleteStatus? status,
    String? message,
  }) {
    return FavoriteDeleteState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
