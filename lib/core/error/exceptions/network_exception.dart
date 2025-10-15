import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  factory NetworkException.fromDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return NetworkException("Tiempo de conexión agotado");
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return NetworkException("Tiempo de espera agotado");
    } else if (e.type == DioExceptionType.connectionError) {
      return NetworkException("No hay conexión a internet");
    } else {
      return NetworkException("Error de red: ${e.message}");
    }
  }
}

class NoInternetException extends NetworkException {
  NoInternetException() : super("Sin conexión a Internet");
}
