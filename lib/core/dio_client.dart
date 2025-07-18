import 'package:dio/dio.dart';

class DioClient {

  static final DioClient _instance = DioClient._internal();

  late final Dio dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.openweathermap.org',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({'appid': "d7f496a9000941071e8d2527c64f26cf"});
          return handler.next(options);
        },
      ),
    );
  }

}