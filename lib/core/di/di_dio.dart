import 'package:clima_app/core/dio_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerHttp() async {
  final appId = dotenv.env["WEATHER_APP_ID"] ?? "";
  final appUrl = dotenv.env["WEATHER_API_URL"] ?? "";

  final dioClient = DioClient(apiKey: appId, url: appUrl);

  getIt.registerSingleton<DioClient>(dioClient);
}
