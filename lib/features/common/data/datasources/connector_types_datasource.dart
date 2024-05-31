import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/data/models/id_name_model.dart';

abstract class ConnectorTypesDataSource {
  Future<GenericPagination<IdNameModel>> getConnectorTypes();
}

class ConnectorTypesDataSourceImpl extends ConnectorTypesDataSource {
  final Dio _dio;

  ConnectorTypesDataSourceImpl(this._dio);

  @override
  Future<GenericPagination<IdNameModel>> getConnectorTypes() async {
    try {
      final response = await _dio.get(
        'common/ConnectTypeList/',
      );
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
