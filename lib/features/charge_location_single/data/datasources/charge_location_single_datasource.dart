import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';

abstract class ChargeLocationSingleDataSource {
  Future<ChargeLocationModel> getLocationSingle(int id);
}

class ChargeLocationSingleDataSourceIMpl implements ChargeLocationSingleDataSource {
  final Dio _dio;

  const ChargeLocationSingleDataSourceIMpl(this._dio);
  @override
  Future<ChargeLocationModel> getLocationSingle(int id) async {
    try {
      final response = await _dio.get(
        'core/charge-point/$id/',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ChargeLocationModel.fromJson(response.data);
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: response.statusCode ?? 0,
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
