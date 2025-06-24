class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Ocurrió un error en el servidor'});
}