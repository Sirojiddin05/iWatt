import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';

abstract class ChargeLocationsDataSource {
  Future<GenericPagination<ChargeLocationModel>> getChargeLocations({required GetChargeLocationParamEntity paramEntity});
  Future<void> saveUnSaveChargeLocation({required int id});
}

class ChargeLocationsDataSourceImpl implements ChargeLocationsDataSource {
  final Dio _dio;

  const ChargeLocationsDataSourceImpl(this._dio);

  @override
  Future<GenericPagination<ChargeLocationModel>> getChargeLocations({required GetChargeLocationParamEntity paramEntity}) async {
    late final String baseUrl;
    if (paramEntity.next.isNotEmpty) {
      baseUrl = paramEntity.next;
    } else if (paramEntity.isForMap) {
      baseUrl = 'chargers/MapLocationList/';
    } else if (paramEntity.isFavourite) {
      baseUrl = 'chargers/SavedLocationList/';
    } else {
      baseUrl = 'chargers/LocationList/';
    }
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: baseUrl != paramEntity.next ? paramEntity.toJson() : null,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = paramEntity.isForMap ? {'results': response.data} : response.data;
        return GenericPagination.fromJson(data, (p0) => ChargeLocationModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<void> saveUnSaveChargeLocation({required int id}) async {
    try {
      final response = await _dio.post(
        'common/SavedLocation/',
        data: {'location': id},
      );
      if (!(response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300)) {
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
