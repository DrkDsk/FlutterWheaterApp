import 'package:clima_app/core/helpers/network_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerHelpers() async {
  getIt.registerSingleton<Connectivity>(Connectivity());

  getIt.registerLazySingleton<NetworkHelper>(
    () => NetworkHelper(
      connectivity: getIt<Connectivity>(),
    ),
  );
}
