import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/profile/data/models/user_model.dart';

abstract class ProfileDatasource {
  Future<UserModel> getUserData();
  Future<UserModel> updateProfile({required UserModel user});
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final Dio _dio;

  const ProfileDatasourceImpl(this._dio);

  @override
  Future<UserModel> getUserData() async {
    try {
      final response = await _dio.get(
        'users/profile-detail/',
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UserModel.fromJson(response.data);
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.error,
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
  Future<UserModel> updateProfile({required UserModel user}) async {
    final data = user.toJson();
    data.removeWhere((key, value) => value == null || value == '');
    try {
      final response = await _dio.patch(
        'users/profile-update/',
        data: data,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return UserModel.fromJson(response.data);
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.error,
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
