import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';

class ConfirmCreditCardUseCase extends UseCase<void, ({String otp, String cardNumber})> {
  final PaymentsRepository paymentsRepository;

  ConfirmCreditCardUseCase({required this.paymentsRepository});

  @override
  Future<Either<Failure, void>> call(({String otp, String cardNumber}) params) {
    return paymentsRepository.confirmCreditCard(otp: params.otp, cardNumber: params.cardNumber);
  }
}

//otp_is_not_correct
