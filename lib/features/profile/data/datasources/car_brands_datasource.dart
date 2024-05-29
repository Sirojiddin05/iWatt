import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/data/models/id_name_model.dart';

abstract class CarBrandsDatasource {
  Future<GenericPagination<IdNameModel>> getManufacturers({String next = '', String searchQuery = ''});
  Future<GenericPagination<IdNameModel>> getModels({String next = '', required int manufacturerId});
}

class CarBrandsDatasourceImpl extends CarBrandsDatasource {
  final Dio _dio;

  CarBrandsDatasourceImpl(this._dio);

  @override
  Future<GenericPagination<IdNameModel>> getManufacturers({String next = '', String searchQuery = ''}) async {
    final baseUrl = next.isNotEmpty ? next : 'core/manufacturers/';
    final params = next.isEmpty ? {'search': searchQuery} : null;
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: params,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          {"results": response.data['data']},
          (p0) => IdNameModel.fromJson(p0 as Map<String, dynamic>),
        );
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

  @override
  Future<GenericPagination<IdNameModel>> getModels({String next = '', required int manufacturerId}) async {
    final baseUrl = next.isNotEmpty ? next : 'core/car-models/';
    final params = next.isEmpty ? {'manufacturer': manufacturerId} : null;
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: params,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson({"results": response.data['data']}, (p0) => IdNameModel.fromJson(p0 as Map<String, dynamic>));
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
