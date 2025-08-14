import 'package:dio/dio.dart';

class DioClient {

  static DioClient? _instance;

  late final Dio dio;

  factory DioClient({required String url, required String apiKey}) {
    _instance ??= DioClient._internal(apiKey: apiKey, url: url);
    return _instance!;
  }

  DioClient._internal({required String url, required String apiKey}) {
    dio = Dio(BaseOptions(
      baseUrl: url,
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