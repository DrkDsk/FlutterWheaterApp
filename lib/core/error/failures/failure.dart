abstract class Failure {
  final String message;

  Failure([this.message = ""]);
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure([super.message]);
}
