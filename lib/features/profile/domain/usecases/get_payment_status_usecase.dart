//
// import 'package:i_watt_app/core/usecases/base_usecase.dart';
// import 'package:i_watt_app/features/profile/domain/entities/payment_status_entity.dart';
// import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';
//
// class GetTransactionStateUseCase extends UseCase<PaymentStatusEntity, TransactionStatusParams> {
//   final PaymentsRepository paymentsRepository;
//
//   GetTransactionStateUseCase({required this.paymentsRepository});
//
//   @override
//   Future<Either<Failure, PaymentStatusEntity>> call(TransactionStatusParams params) {
//     return paymentsRepository.getTransactionState(amount: params.amount, transactionId: params.transactionId);
//   }
// }
//
// class TransactionStatusParams {
//   final String amount;
//   final int transactionId;
//
//   TransactionStatusParams({required this.amount, required this.transactionId});
// }
