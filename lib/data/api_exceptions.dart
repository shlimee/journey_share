abstract class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});
}

class UnkownException extends ApiException {
  UnkownException({required super.statusCode, required super.message});
}

class NotImplementedException extends ApiException {
  NotImplementedException({required super.statusCode, required super.message});
}

class ForbiddenException extends ApiException {
  ForbiddenException({required super.statusCode, required super.message});
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({required super.statusCode, required super.message});
}

class BadRequestException extends ApiException {
  BadRequestException({required super.statusCode, required super.message});
}
