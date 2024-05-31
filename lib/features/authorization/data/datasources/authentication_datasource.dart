import 'dart:async';

import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';

abstract class AuthenticationDatasource {
  Future<void> validateToken();
}

class AuthenticationDatasourceImpl extends AuthenticationDatasource {
  final Dio dio;

  AuthenticationDatasourceImpl({required this.dio});

  @override
  Future<void> validateToken() async {
    try {
      final response = await dio.get(
        'users/profile-detail/',
      );
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        final model = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: model.statusCode,
          errorMessage: model.message,
          error: model.error,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
