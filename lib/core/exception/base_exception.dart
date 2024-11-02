// Base exception class for all custom exceptions
class BaseException implements Exception {
  final String message;
  final int? statusCode;

  const BaseException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}
