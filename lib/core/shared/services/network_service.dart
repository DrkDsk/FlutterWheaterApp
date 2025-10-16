import 'dart:async';
import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity connectivity;

  const NetworkService({required this.connectivity});

  Future<void> checkConnection() async {
    final result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      throw NoInternetException();
    }
  }
}
