import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/navigation/data/models/version_model.dart';

abstract class VersionCheckDataSource {
  Future<VersionModel> getAppLatestVersion();
}

class VersionCheckDataSourceImpl implements VersionCheckDataSource {
  final Dio dio;

  VersionCheckDataSourceImpl(this.dio);
  @override
  Future<VersionModel> getAppLatestVersion() async {
    try {
      //TODO: Change the URL to the correct one
      final response = await dio.getUri(Uri.parse('https://zty.uicgroup.tech/api/v1/core/version-history/'));
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return VersionModel.fromJson(response.data);
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
