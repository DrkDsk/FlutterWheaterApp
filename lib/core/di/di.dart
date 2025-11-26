import 'package:clima_app/core/di/di_blocs.dart';
import 'package:clima_app/core/di/di_datasources.dart';
import 'package:clima_app/core/di/di_dio.dart';
import 'package:clima_app/core/di/di_helpers.dart';
import 'package:clima_app/core/di/di_hive.dart';
import 'package:clima_app/core/di/di_repositories.dart';
import 'package:clima_app/core/di/di_services.dart';
import 'package:clima_app/core/di/di_use_cases.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await initHive();
  await registerHttp();
  await registerHelpers();
  await registerDataSources();
  await registerRepositories();
  await registerServices();
  await registerUseCases();
  await registerBlocs();
}
