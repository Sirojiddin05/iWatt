import 'dart:async';

import 'package:dio/dio.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/error/error_handler.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';

abstract class AuthenticationDatasource {
  Future<void> validateToken();
}

class AuthenticationDatasourceImpl extends AuthenticationDatasource {
  final Dio dio;

  AuthenticationDatasourceImpl({required this.dio});

  @override
  Future<void> validateToken() async {
    final accessToken = StorageRepository.getString(StorageKeys.accessToken);
    try {
      final response = await dio.get(
        'auth/validate',
        options: Options(
          headers: {'Authorization': accessToken},
        ),
      );
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        final model = ErrorModel.fromJson(response.data);
        throw ServerException(statusCode: model.code, errorMessage: model.message);
      }
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
