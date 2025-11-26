import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clima_app/core/helpers/network_helper.dart';
import 'package:clima_app/core/shared/ui/cubits/network_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final NetworkHelper _networkService;
  StreamSubscription? _subscription;

  NetworkCubit({required NetworkHelper networkService})
      : _networkService = networkService,
        super(const NetworkState()) {
    _monitorNetwork();
  }

  void _monitorNetwork() {
    _subscription =
        _networkService.connectivity.onConnectivityChanged.listen((result) {
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
