import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/navigation/data/models/version_features_model.dart';

abstract class InstructionsDataSource {
  Future<GenericPagination<VersionFeaturesModel>> getInstructions(String type);
}

class InstructionsDataSourceImpl extends InstructionsDataSource {
  final Dio dio;

  InstructionsDataSourceImpl(this.dio);

  @override
  Future<GenericPagination<VersionFeaturesModel>> getInstructions(String type) async {
    try {
      final response = await dio.get('common/InstructionList/', queryParameters: {"type": type});
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => VersionFeaturesModel.fromJson(p0 as Map<String, dynamic>),
        );
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
