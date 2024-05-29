import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/domain/entities/credit_card_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';

class GetCreditCardsUseCase extends UseCase<GenericPagination<CreditCardEntity>, String?> {
  final PaymentsRepository paymentsRepository;

  GetCreditCardsUseCase({required this.paymentsRepository});

  @override
  Future<Either<Failure, GenericPagination<CreditCardEntity>>> call(String? params) {
    return paymentsRepository.getCreditCards(next: params);
  }
}
