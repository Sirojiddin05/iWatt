import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';
import 'package:i_watt_app/features/profile/domain/usecases/pay_with_card_params.dart';

class PayWithCardUseCase extends UseCase<void, PayWithCardParams> {
  final PaymentsRepository paymentsRepository;

  PayWithCardUseCase({required this.paymentsRepository});

  @override
  Future<Either<Failure, void>> call(PayWithCardParams params) {
    return paymentsRepository.payWithCard(cardId: params.cardId, amount: params.amount);
  }
}
