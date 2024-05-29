import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  final String error;
  const ServerFailure({required super.errorMessage, this.error = ''});
}

class DioFailure extends Failure {
  final DioExceptionType type;
  const DioFailure({required super.errorMessage, this.type = DioExceptionType.badResponse});
}

class ParsingFailure extends Failure {
  const ParsingFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.errorMessage});
}
