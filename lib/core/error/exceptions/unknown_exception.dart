class UnknownException implements Exception {
  final String message;

  UnknownException({this.message = "Ha ocurrido un error inesperado, intente más tarde."});
}