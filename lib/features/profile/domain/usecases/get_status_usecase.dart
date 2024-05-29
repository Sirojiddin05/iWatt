// import 'package:k_watt_app/core/usecases/usecase.dart';
// import 'package:k_watt_app/features/common/pagination/models/generic_pagination.dart';
// import 'package:k_watt_app/features/menu/menu/domain/entities/payment_type_status_entity.dart';
// import 'package:k_watt_app/features/menu/menu/domain/repositories/payments_repository.dart';
// import 'package:k_watt_app/utils/either.dart';
// import 'package:k_watt_app/utils/failures.dart';
//
// class GetPaymentSystemsUseCase extends UseCase<GenericPagination<PaymentTypeStatusEntity>, NoParams> {
//   final PaymentsRepository paymentsRepository;
//
//   GetPaymentSystemsUseCase({required this.paymentsRepository});
//
//   @override
//   Future<Either<Failure, GenericPagination<PaymentTypeStatusEntity>>> call(NoParams params) {
//     return paymentsRepository.getPaymentSystems();
//   }
// }
