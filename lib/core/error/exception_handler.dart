import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String errorMessage;
  final int statusCode;
  final String error;

  const ServerException({this.statusCode = 400, this.errorMessage = 'error', required this.error});

  @override
  String toString() => 'ServerException(statusCode: $statusCode, errorMessage: $errorMessage)';
}

class CustomDioException implements Exception {
  final String errorMessage;
  final DioExceptionType type;

  const CustomDioException({required this.errorMessage, required this.type});
  @override
  String toString() => 'CustomDioException(errorMessage: $errorMessage, type: $type)';
}

class ParsingException implements Exception {
  final String errorMessage;
  const ParsingException({required this.errorMessage});
  @override
  String toString() => 'CustomDioException(errorMessage: $errorMessage)';
}

class CacheException implements Exception {
  final String errorMessage;
  const CacheException({required this.errorMessage});
  @override
  String toString() => 'CacheException(errorMessage: $errorMessage)';
}
