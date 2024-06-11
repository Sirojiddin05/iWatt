import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/transaction_entity.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

abstract class TransactionHistoryRepository {
  Future<Either<Failure, GenericPagination<TransactionEntity>>> getTransactions({required String next});
  Future<Either<Failure, TransactionMessageEntity>> getSingleTransaction({required int transactionId});
}
