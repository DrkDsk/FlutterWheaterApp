import 'package:dio/dio.dart';

class DioClient {

  static DioClient? _instance;

  late final Dio dio;

  factory DioClient({required String apiKey}) {
    _instance ??= DioClient._internal(apiKey);
    return _instance!;
  }

  DioClient._internal(String apiKey) {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.openweathermap.org',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters.addAll({'appid': apiKey});
          return handler.next(options);
        },
      ),
    );
  }

}