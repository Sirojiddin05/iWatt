import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/charge_location_single/data/models/charge_location_single_model.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';

abstract class ChargeLocationSingleDataSource {
  Future<ChargeLocationSingleModel> getLocationSingle(int id);
}

class ChargeLocationSingleDataSourceImpl implements ChargeLocationSingleDataSource {
  final Dio _dio;

  const ChargeLocationSingleDataSourceImpl(this._dio);
  @override
  Future<ChargeLocationSingleModel> getLocationSingle(int id) async {
    try {
      final response = await _dio.get(
        'chargers/LocationDetail/$id/',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ChargeLocationSingleModel.fromJson(response.data);
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: response.statusCode ?? 0,
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
