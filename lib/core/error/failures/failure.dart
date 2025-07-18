abstract class Failure {
  final String message;
  Failure([this.message = ""]);
}

class CacheFailure extends Failure {}
class UnexpectedFailure extends Failure {}
class GenericFailure extends Failure {
  GenericFailure([super.message]);
}
class ServerFailure extends Failure {
  ServerFailure([super.message]);
}