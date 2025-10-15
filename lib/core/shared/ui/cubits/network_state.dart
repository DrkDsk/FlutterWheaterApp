import 'package:equatable/equatable.dart';

enum NetworkStatus { connected, disconnected }

final class NetworkState with EquatableMixin {
  final NetworkStatus status;

  const NetworkState({this.status = NetworkStatus.connected});

  NetworkState copyWith({
    NetworkStatus? status,
  }) {
    return NetworkState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
