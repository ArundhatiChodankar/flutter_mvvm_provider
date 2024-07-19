class AppExceptions implements Exception {
  final String? _prefix, _message;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix: $_message";
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message])
      : super(message, "No Internet Connection");
}

class ServerTimeOut extends AppExceptions {
  ServerTimeOut([String? message]) : super(message, "Server Timeout");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message])
      : super(message, "Bad Request Exception");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message])
      : super(message, "Invalid input Exception Exception");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, "Unauthorized Exception");
}
