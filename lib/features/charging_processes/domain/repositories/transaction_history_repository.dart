import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

abstract class TransactionHistoryRepository {
  Future<Either<Failure, GenericPagination<TransactionMessageEntity>>> getTransactions({required String next});
  Future<Either<Failure, TransactionMessageEntity>> getSingleTransaction({required int transactionId});
}
