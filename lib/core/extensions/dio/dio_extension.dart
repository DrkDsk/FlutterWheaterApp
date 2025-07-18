import 'package:dio/dio.dart';

extension DioExceptionMapper on DioException {
  String get userFriendlyMessage {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return 'Tiempo de conexión agotado.';
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de respuesta agotado.';
      case DioExceptionType.badResponse:
        return 'Respuesta inválida del servidor.';
      case DioExceptionType.sendTimeout:
        return 'Tiempo de envío agotado.';
      case DioExceptionType.connectionError:
        return 'Error de conexión.';
      case DioExceptionType.cancel:
        return 'Solicitud cancelada.';
      case DioExceptionType.unknown:
      default:
        return 'Error inesperado.';
    }
  }
}
