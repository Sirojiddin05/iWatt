import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';

abstract class ChangeLanguageDataSource {
  Future<void> changeLanguage({required String languageCode});
}

class ChangeLanguageDataSourceImpl implements ChangeLanguageDataSource {
  final Dio _dio;

  ChangeLanguageDataSourceImpl(this._dio);

  @override
  Future<void> changeLanguage({required String languageCode}) async {
    try {
      final response = await _dio.patch(
        'users/profile-update/',
        data: {'language': languageCode},
      );
      if (!(response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300)) {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
      print('ChangeLanguageDataSourceImpl: changeLanguage: success');
      return;
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
