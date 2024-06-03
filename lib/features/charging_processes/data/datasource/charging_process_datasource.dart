import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/charging_processes/data/models/in_progress_charging_model.dart';
import 'package:i_watt_app/features/charging_processes/data/models/start_charging_process_response_model.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_param_entity.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';

abstract class ChargingProcessDataSource {
  Future<CommandResultResponseModel> startChargingProcess({required StartProcessParamEntity params});
  Future<CommandResultResponseModel> stopChargingProcess({required int transactionId});
  Future<GenericPagination<InProgressChargingModel>> getChargingProcesses();
}

class ChargingProcessDataSourceImpl implements ChargingProcessDataSource {
  final Dio _dio;
  const ChargingProcessDataSourceImpl(this._dio);
  @override
  Future<CommandResultResponseModel> startChargingProcess({required StartProcessParamEntity params}) async {
    Map<String, dynamic> data = {};
    data.putIfAbsent('connector', () => params.connectionId);
    data.putIfAbsent('is_limited', () => params.isLimited);
    try {
      final response = await _dio.post('chargers/StartChargingCommand/', data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CommandResultResponseModel.fromJson(response.data);
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
  Future<CommandResultResponseModel> stopChargingProcess({required int transactionId}) async {
    Map<String, dynamic> data = {};
    data.putIfAbsent('transaction', () => transactionId);
    try {
      final response = await _dio.post('chargers/StopChargingCommand/', data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CommandResultResponseModel.fromJson(response.data);
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
  Future<GenericPagination<InProgressChargingModel>> getChargingProcesses() async {
    try {
      final response = await _dio.get('chargers/InProgressChargingTransactionList/');
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => InProgressChargingModel.fromJson(p0 as Map<String, dynamic>),
        );
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
