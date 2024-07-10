import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';
import 'package:i_watt_app/features/map/data/models/cluster_model.dart';

abstract class MapRemoteDataSource {
  Future<GenericPagination<ClusterModel>> getClusters({required GetChargeLocationParamEntity params});
  Future<ChargeLocationModel> getLocation({required String key});
  Future<List<ChargeLocationModel>> getMapLocations();
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final Dio _dio;
  const MapRemoteDataSourceImpl(this._dio);
  @override
  Future<GenericPagination<ClusterModel>> getClusters({required GetChargeLocationParamEntity params}) async {
    try {
      final response = await _dio.get(
        'chargers/MapClusterList/',
        queryParameters: params.toJson(),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson({'results': response.data}, (p0) => ClusterModel.fromJson(p0 as Map<String, dynamic>));
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
  Future<ChargeLocationModel> getLocation({required String key}) async {
    try {
      final response = await _dio.get(
        'chargers/MapLocationList/',
        queryParameters: {'quadkey': key},
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ChargeLocationModel.fromJson(response.data[0]);
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
  Future<List<ChargeLocationModel>> getMapLocations() async {
    try {
      final response = await _dio.get(
        'chargers/MapLocationList/',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = GenericPagination<ChargeLocationModel>.fromJson(
            {'results': response.data}, (p0) => ChargeLocationModel.fromJson(p0 as Map<String, dynamic>)).results;
        return data;
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
