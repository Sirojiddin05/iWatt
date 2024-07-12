import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/location_filter_key_model.dart';

abstract class LocationFilterKeyDataSource {
  Future<List<LocationFilterKeyModel>> getLocationFilterKeys();
}

class LocationFilterKeyDataSourceImpl implements LocationFilterKeyDataSource {
  final Dio dio;

  const LocationFilterKeyDataSourceImpl(this.dio);

  @override
  Future<List<LocationFilterKeyModel>> getLocationFilterKeys() async {
    try {
      final response = await dio.get('common/LocationFilterKey/');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return (response.data as List<dynamic>)
            .map((e) => LocationFilterKeyModel.fromJson(e as Map<String, dynamic>))
            .toList();
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
