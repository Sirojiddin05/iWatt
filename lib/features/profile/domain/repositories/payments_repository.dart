import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/data/models/credit_card_model.dart';

abstract class PaymentsRepository {
  Future<Either<Failure, GenericPagination<CreditCardModel>>> getCreditCards({String? next});

  Future<Either<Failure, String>> createCreditCard({required String cardNumber, required String expireDate});

  Future<Either<Failure, void>> confirmCreditCard({required String otp, required String cardNumber});

  Future<Either<Failure, void>> deleteCreditCard({required int userCardId});

  Future<Either<Failure, void>> payWithCard({required int cardId, required int amount});
// Future<Either<Failure, GenericPagination<PaymentTypeStatusEntity>>> getPaymentSystems();
// Future<Either<Failure, PaymentStatusEntity>> getTransactionState({required String amount, required int transactionId});
// Future<Either<Failure, TransactionLinkEntity>> getTransactionLink({required int amount, required String type});
}
