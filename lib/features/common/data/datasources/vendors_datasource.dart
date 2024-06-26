import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/data/models/id_name_model.dart';

abstract class VendorsDatasource {
  Future<GenericPagination<IdNameModel>> getVendors({String next, String searchPattern});
}

class VendorsDataSourceImpl extends VendorsDatasource {
  final Dio _dio;
  VendorsDataSourceImpl(this._dio);
  @override
  Future<GenericPagination<IdNameModel>> getVendors({String next = '', String searchPattern = ''}) async {
    late final String baseUrl;
    Map<String, dynamic>? params;
    baseUrl = next.isNotEmpty ? next : 'chargers/VendorList/';
    if (searchPattern.isNotEmpty) {
      params = {'search': searchPattern};
    }
    try {
      final response = await _dio.get(baseUrl, queryParameters: params);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(response.data, (p0) => IdNameModel.fromJson(p0 as Map<String, dynamic>));
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
      throw CustomDioException(
        errorMessage: message,
        type: type,
      );
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
