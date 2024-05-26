import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/about_data_model.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';

abstract class AboutUsDataSource {
  Future<AboutUsModel> getAbout();
}

class AboutUsDataSourceImpl implements AboutUsDataSource {
  final Dio dio;

  const AboutUsDataSourceImpl(this.dio);

  @override
  Future<AboutUsModel> getAbout() async {
    try {
      final response = await dio.get('core/about/');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AboutUsModel.fromJson(response.data);
      } else {
        final error = ErrorModel.fromJson(response.data);
        throw ServerException(statusCode: response.statusCode ?? 0, errorMessage: error.message);
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
