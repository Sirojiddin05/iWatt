import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/data/models/transaction_message_model.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

abstract class TransactionHistoryDatasource {
  Future<GenericPagination<TransactionMessageEntity>> getTransactionHistory({String next = ''});
  Future<TransactionMessageEntity> getSingleTransaction(int transactionId);
}

class TransactionHistoryDatasourceImpl implements TransactionHistoryDatasource {
  final Dio _dio;

  const TransactionHistoryDatasourceImpl(this._dio);
  @override
  Future<GenericPagination<TransactionMessageEntity>> getTransactionHistory({String next = ''}) async {
    final baseUrl = next.isNotEmpty ? next : 'chargers/ChargingTransactionList/';
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (data) => TransactionMessageModel.fromJson(data as Map<String, dynamic>),
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

  @override
  Future<TransactionMessageEntity> getSingleTransaction(int transactionId) async {
    try {
      final response = await _dio.get('chargers/ChargingTransactionDetail/$transactionId/');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return TransactionMessageModel.fromJson(response.data as Map<String, dynamic>);
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
