import 'package:dio/dio.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';

abstract class SignInDataSource {
  Future<String> login({required String phone});
  Future<bool> verifyCode({required String code, required String phone, required String session, required String type});
  Future<void> loginWithQr({required String token});
}

class SignInDataSourceImpl extends SignInDataSource {
  final Dio _dio;

  SignInDataSourceImpl(this._dio);

  @override
  Future<String> login({required String phone}) async {
    try {
      final response = await _dio.post(
        'users/login/',
        data: {'phone': '+998${phone.replaceAll(' ', '')}'},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data['session'];
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
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

  @override
  Future<bool> verifyCode({
    required String code,
    required String phone,
    required String session,
    required String type,
  }) async {
    try {
      final response = await _dio.post(
        'users/login/confirm/',
        data: {
          "type_": type,
          "phone": "+998${phone.replaceAll(' ', '')}",
          "code": code,
          "session": session,
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        await StorageRepository.putString(StorageKeys.accessToken, 'Bearer ${response.data[StorageKeys.accessToken]}');
        await StorageRepository.putString(StorageKeys.refreshToken, '${response.data[StorageKeys.refreshToken]}');
        return response.data["is_new"];
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
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

  @override
  Future<void> loginWithQr({required String token}) async {
    try {
      final response = await _dio.post(
        'users/token/refresh/',
        data: {"refresh": token},
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        await StorageRepository.putString(StorageKeys.accessToken, 'Bearer ${response.data['access']}');
        await StorageRepository.putString(StorageKeys.refreshToken, '${response.data['refresh']}');
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
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
