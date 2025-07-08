abstract class Failure {
  final String message;
  Failure([this.message = ""]);
}

class CacheFailure extends Failure {}
class UnexpectedFailure extends Failure {}