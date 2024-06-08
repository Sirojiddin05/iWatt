import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/charging_processes/domain/repositories/transaction_history_repository.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

class GetSingleTransactionUseCase implements UseCase<TransactionMessageEntity, int> {
  final TransactionHistoryRepository repo;
  const GetSingleTransactionUseCase(this.repo);

  @override
  Future<Either<Failure, TransactionMessageEntity>> call(int params) async {
    return await repo.getSingleTransaction(transactionId: params);
  }
}
