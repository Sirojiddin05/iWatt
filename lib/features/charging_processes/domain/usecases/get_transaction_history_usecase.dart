import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charging_processes/domain/repositories/transaction_history_repository.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

class GetTransactionHistoryUseCase implements UseCase<GenericPagination<TransactionMessageEntity>, String> {
  final TransactionHistoryRepository repo;
  const GetTransactionHistoryUseCase(this.repo);

  @override
  Future<Either<Failure, GenericPagination<TransactionMessageEntity>>> call(String params) async {
    return await repo.getTransactions(next: params);
  }
}
