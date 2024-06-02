import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/about_us_model.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/help_model.dart';

abstract class AboutUsDataSource {
  Future<HelpModel> getHelp();

  Future<AboutUsModel> getAboutUs();
}

class AboutUsDataSourceImpl implements AboutUsDataSource {
  final Dio dio;

  const AboutUsDataSourceImpl(this.dio);

  @override
  Future<HelpModel> getHelp() async {
    try {
      final response = await dio.get('common/MainSettings/');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return HelpModel.fromJson(response.data);
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
  Future<AboutUsModel> getAboutUs() async {
    try {
      final response = await dio.get('common/StaticPage/about-us/');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AboutUsModel.fromJson(response.data);
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
