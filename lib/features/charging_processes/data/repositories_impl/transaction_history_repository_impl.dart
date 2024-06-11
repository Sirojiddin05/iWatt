import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/charging_processes/data/datasource/transaction_history_datasource.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/transaction_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/repositories/transaction_history_repository.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

class TransactionHistoryRepositoryImpl implements TransactionHistoryRepository {
  final TransactionHistoryDatasource dataSource;

  TransactionHistoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, TransactionMessageEntity>> getSingleTransaction({required int transactionId}) async {
    try {
      final result = await dataSource.getSingleTransaction(transactionId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<TransactionEntity>>> getTransactions({required String next}) async {
    try {
      final result = await dataSource.getTransactionHistory(next: next);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }
}
