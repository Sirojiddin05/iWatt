import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/data/models/id_name_model.dart';

abstract class AppealDataSource {
  Future<GenericPagination<IdNameModel>> getAppeals({required String next});
  Future<void> sendAppeal({required int location, required String appeal});
}

class AppealDataSourceImpl extends AppealDataSource {
  final Dio dio;

  AppealDataSourceImpl(this.dio);

  @override
  Future<void> sendAppeal({required int location, required String appeal}) async {
    Map<String, dynamic> data = {};
    data.putIfAbsent('name', () => appeal);
    data.putIfAbsent('charge_point', () => location);
    try {
      final response = await dio.post('common/UserAppealCreate/', data: data);
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
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
  Future<GenericPagination<IdNameModel>> getAppeals({required String next}) async {
    final baseUrl = next.isEmpty ? 'common/AppealTypeList/' : next;

    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(response.data, (p0) => IdNameModel.fromJson(p0 as Map<String, dynamic>));
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
