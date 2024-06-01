import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/data/models/credit_card_model.dart';
import 'package:i_watt_app/features/profile/data/models/payment_status_model.dart';

abstract class PaymentsDataSource {
  Future<GenericPagination<CreditCardModel>> getCreditCards({String? next});

  Future<String> createCreditCard({required String cardNumber, required String expireDate});

  Future<void> confirmCreditCard({required String otp, required String cardNumber});

  Future<void> deleteCreditCard({required int userCardId});

  Future<void> payWithCard({required int cardId, required int amount});

// Future<GenericPagination<PaymentTypeStatusModel>> getPaymentSystems();
//
// Future<PaymentStatusModel> getPaymentStatus({required String amount, required transactionId});
//
// Future<TransactionLinkModel> getTransactionLink({required int amount, required String type});
}

class PaymentsDataSourceImpl extends PaymentsDataSource {
  final Dio dio;

  PaymentsDataSourceImpl({required this.dio});

  // @override
  // Future<PaylovLinkModel> getPaylovLink({required int amount}) async {
  //   var fdata = FormData.fromMap({
  //     "amount": amount,
  //   });
  //   try {
  //     final response = await dio.post(
  //       'payments/paylov/link/',
  //       data: fdata,
  //       options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
  //     );
  //     if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
  //       return PaylovLinkModel.fromJson(response.data);
  //     } else {
  //       throw ServerException(statusCode: response.statusCode!, errorMessage: response.data.toString());
  //     }
  //   } on ServerException {
  //     rethrow;
  //   } on DioException {
  //     rethrow;
  //   } on Exception catch (e) {
  //     throw ParsingException(errorMessage: e.toString());
  //   }
  // }
  //
  // @override
  // Future<TransactionLinkModel> getTransactionLink({required int amount, required String type}) async {
  //   try {
  //     final response = await dio.post(
  //       'payments/payment-links/',
  //       data: {"amount": amount, "payment_type": type},
  //       options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
  //     );
  //     if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
  //       return TransactionLinkModel.fromJson(response.data);
  //     } else {
  //       throw ServerException(statusCode: response.statusCode!, errorMessage: response.data.toString());
  //     }
  //   } on ServerException {
  //     rethrow;
  //   } on DioException {
  //     rethrow;
  //   } on Exception catch (e) {
  //     throw ParsingException(errorMessage: e.toString());
  //   }
  // }
  //
  // @override
  // Future<PaymentStatusModel> getPaymentStatus({required String amount, required transactionId}) async {
  //   try {
  //     final response = await dio.post(
  //       'payments/payme/link/status/',
  //       data: {
  //         "amount": amount,
  //         "transaction_id": transactionId,
  //       },
  //       options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
  //     );
  //     if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
  //       return PaymentStatusModel.fromJson(response.data);
  //     } else {
  //       throw ServerException(
  //           statusCode: response.statusCode!, errorMessage: PaymentStatusModel.fromJson(response.data).status);
  //     }
  //   } on ServerException {
  //     rethrow;
  //   } on DioException {
  //     rethrow;
  //   } on Exception catch (e) {
  //     throw ParsingException(errorMessage: e.toString());
  //   }
  // }
  //
  // @override
  // Future<GenericPagination<PaymentTypeStatusModel>> getPaymentSystems() async {
  //   try {
  //     final response = await dio.get(
  //       'core/payment_status/',
  //       queryParameters: {
  //         "limit": 4,
  //       },
  //       options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
  //     );
  //     if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
  //       return GenericPagination.fromJson(
  //           response.data, (p0) => PaymentTypeStatusModel.fromJson(p0 as Map<String, dynamic>));
  //     } else {
  //       throw ServerException(
  //           statusCode: response.statusCode!, errorMessage: PaymentStatusModel.fromJson(response.data).status);
  //     }
  //   } on ServerException {
  //     rethrow;
  //   } on DioException {
  //     rethrow;
  //   } on Exception catch (e) {
  //     throw ParsingException(errorMessage: e.toString());
  //   }
  // }

  @override
  Future<GenericPagination<CreditCardModel>> getCreditCards({String? next}) async {
    try {
      final response = await dio.get(
        next ?? 'payment/UserCardList/',
        options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(response.data, (p0) => CreditCardModel.fromJson(p0 as Map<String, dynamic>));
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: PaymentStatusModel.fromJson(response.data).status,
          error: '',
        );
      }
    } on ServerException {
      rethrow;
    } on DioException {
      rethrow;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<String> createCreditCard({required String cardNumber, required String expireDate}) async {
    try {
      final response = await dio.post(
        '/payment/CardCreate/',
        data: {"card_number": cardNumber, "expire_date": expireDate},
        options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data['otp_sent_phone'] as String;
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> confirmCreditCard({required String otp, required String cardNumber}) async {
    try {
      final response = await dio.post(
        'payments/paylov/confirm-user-card/',
        data: {
          "otp": otp,
          "card_number": cardNumber,
        },
        options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> deleteCreditCard({required int userCardId}) async {
    try {
      final response = await dio.delete(
        'payments/paylov/delete-user-card/$userCardId',
        // data: {
        //   "user_card_id": userCardId,
        // },
        options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> payWithCard({required int cardId, required int amount}) async {
    try {
      final response = await dio.post(
        'payments/paylov/receipts/pay/',
        data: {"card_id": cardId, "amount": amount},
        options: Options(headers: {"Authorization": "Bearer ${StorageRepository.getString('token')}"}),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
