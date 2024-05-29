import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/data/datasources/payments_data_source.dart';
import 'package:i_watt_app/features/profile/data/models/credit_card_model.dart';
import 'package:i_watt_app/features/profile/domain/repositories/payments_repository.dart';

class PaymentsRepositoryImpl extends PaymentsRepository {
  final PaymentsDataSource dataSource;

  PaymentsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> payWithCard({required int cardId, required int amount}) async {
    try {
      final result = await dataSource.payWithCard(cardId: cardId, amount: amount);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on DioException {
      return Left(const DioFailure(errorMessage: ''));
    }
  }

  @override
  Future<Either<Failure, GenericPagination<CreditCardModel>>> getCreditCards({String? next}) async {
    try {
      final result = await dataSource.getCreditCards(next: next);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on DioException {
      return Left(const DioFailure(errorMessage: ''));
    }
  }

  @override
  Future<Either<Failure, String>> createCreditCard({required String cardNumber, required String expireDate}) async {
    try {
      final result = await dataSource.createCreditCard(cardNumber: cardNumber, expireDate: expireDate);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on DioException {
      return Left(const DioFailure(errorMessage: ''));
    }
  }

  @override
  Future<Either<Failure, void>> confirmCreditCard({required String otp, required String cardNumber}) async {
    try {
      final result = await dataSource.confirmCreditCard(otp: otp, cardNumber: cardNumber);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on DioException {
      return Left(const DioFailure(errorMessage: ''));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCreditCard({required int userCardId}) async {
    try {
      final result = await dataSource.deleteCreditCard(userCardId: userCardId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on DioException {
      return Left(const DioFailure(errorMessage: ''));
    }
  }

// @override
// Future<Either<Failure, GenericPagination<PaymentTypeStatusEntity>>> getPaymentSystems() async {
//   try {
//     final result = await dataSource.getPaymentSystems();
//     return Right(result);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(errorMessage: e.errorMessage));
//   } on DioException {
//     return Left(const DioFailure());
//   }
// }
//
// @override
// Future<Either<Failure, TransactionLinkEntity>> getTransactionLink({required int amount, required String type}) async {
//   try {
//     final result = await dataSource.getTransactionLink(amount: amount, type: type);
//     return Right(result);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(errorMessage: e.errorMessage));
//   } on DioException {
//     return Left(const DioFailure(errorMessage: ''));
//   }
// }
//
// @override
// Future<Either<Failure, PaymentStatusEntity>> getTransactionState(
//     {required String amount, required int transactionId}) async {
//   try {
//     final result = await dataSource.getPaymentStatus(amount: amount, transactionId: transactionId);
//     return Right(result);
//   } on ServerException catch (e) {
//     return Left(ServerFailure(errorMessage: e.errorMessage));
//   } on DioException {
//     return Left(const DioFailure());
//   }
// }
}
