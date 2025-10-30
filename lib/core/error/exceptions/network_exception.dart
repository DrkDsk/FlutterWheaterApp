class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class NoInternetException extends NetworkException {
  NoInternetException()
      : super(
            "Sin conexión a Internet, checa tu conexión o intenta nuevamente");
}
