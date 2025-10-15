import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clima_app/core/shared/ui/cubits/network_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  StreamSubscription? _subscription;

  NetworkCubit({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(const NetworkState()) {
    _monitorNetwork();
  }

  void _monitorNetwork() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        emit(state.copyWith(status: NetworkStatus.disconnected));
      } else {
        emit(state.copyWith(status: NetworkStatus.connected));
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
