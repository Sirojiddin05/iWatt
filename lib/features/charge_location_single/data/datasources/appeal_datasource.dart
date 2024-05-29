import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/charge_location_single/data/models/appeal_model.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';

abstract class AppealDataSource {
  Future<GenericPagination<AppealModel>> getAppeals({required String next});
  Future<void> sendAppeal({required int id, required int location, String otherAppeal = ''});
}

class AppealDataSourceImpl extends AppealDataSource {
  final Dio dio;

  AppealDataSourceImpl({required this.dio});

  @override
  Future<void> sendAppeal({required int id, required int location, String otherAppeal = ''}) async {
    Map<String, dynamic> data = {};
    if (id != 0) {
      data.putIfAbsent('title', () => id);
    } else {
      data.putIfAbsent('appeal_user', () => otherAppeal);
    }
    data.putIfAbsent('location', () => location);
    try {
      final response = await dio.post('core/chargers/appeals/', data: data);
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<AppealModel>> getAppeals({required String next}) async {
    final baseUrl = next.isEmpty ? 'core/appeals/' : next;

    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(response.data, (p0) => AppealModel.fromJson(p0 as Map<String, dynamic>));
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
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
