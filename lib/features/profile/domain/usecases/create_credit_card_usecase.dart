import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/entities/create_card_params.dart';
import 'package:i_watt_app/features/profile/domain/entities/create_credit_card_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';

class CreateCreditCardUseCase extends UseCase<CreateCreditCardEntity, CreateCardParams> {
  final PaymentsRepository paymentsRepository;

  CreateCreditCardUseCase({required this.paymentsRepository});

  @override
  Future<Either<Failure, CreateCreditCardEntity>> call(CreateCardParams params) {
    return paymentsRepository.createCreditCard(cardNumber: params.cardNumber, expireDate: params.expireDate);
  }
}
