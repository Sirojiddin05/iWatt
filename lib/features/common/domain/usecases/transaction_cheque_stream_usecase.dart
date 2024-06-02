import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';
import 'package:i_watt_app/features/common/domain/repositories/socket_repository.dart';

class TransactionChequeStreamUseCase implements StreamUseCase<TransactionMessageEntity, NoParams> {
  final SocketRepository repository;
  TransactionChequeStreamUseCase(this.repository);
  @override
  Stream<TransactionMessageEntity> call(NoParams params) async* {
    yield* repository.transactionChequeStream();
  }
}
