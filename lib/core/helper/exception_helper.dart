abstract class AppException implements Exception {
  final String errorMessage;
  final int statusCode;
  final String? icon;

  AppException({
    required this.errorMessage,
    required this.statusCode,
    this.icon,
  });
}

class ServerException extends AppException {
  ServerException({
    required super.errorMessage,
    required super.statusCode,
    super.icon,
  });
}

class NetworkException extends AppException {
  NetworkException({
    required super.errorMessage,
    required super.statusCode,
    super.icon,
  });
}

class AuthoriseException extends AppException {
  AuthoriseException({
    required super.errorMessage,
    required super.statusCode,
    super.icon,
  });
}

class NoContentException extends AppException {
  NoContentException({
    required super.errorMessage,
    required super.statusCode,
    super.icon,
  });
}

class DefaultException extends AppException {
  DefaultException({
    required super.errorMessage,
    required super.statusCode,
    super.icon,
  });
}

class ValidationException extends AppException {
  ValidationException({
    required super.errorMessage,
    required super.statusCode,
    super.icon,
  });
}

