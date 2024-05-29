import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';

class DeleteCreditCardUseCase extends UseCase<void, int> {
  final PaymentsRepository paymentsRepository;

  DeleteCreditCardUseCase({required this.paymentsRepository});

  @override
  Future<Either<Failure, void>> call(int params) {
    return paymentsRepository.deleteCreditCard(userCardId: params);
  }
}
