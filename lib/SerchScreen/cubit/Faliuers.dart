class Failure {
  String errorMsg;

  Failure({required this.errorMsg});
}

class ServerError extends Failure {
  ServerError({required super.errorMsg});
}
