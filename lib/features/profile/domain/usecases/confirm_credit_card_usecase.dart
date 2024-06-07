import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';

class ConfirmCreditCardUseCase extends UseCase<void, ({String otp, String cardToken})> {
  final PaymentsRepository paymentsRepository;

  ConfirmCreditCardUseCase({required this.paymentsRepository});

  @override
  Future<Either<Failure, void>> call(({String otp, String cardToken}) params) {
    return paymentsRepository.confirmCreditCard(otp: params.otp, cardToken: params.cardToken);
  }
}

//otp_is_not_correct
