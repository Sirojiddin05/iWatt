import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/data/models/create_credit_card_model.dart';
import 'package:i_watt_app/features/profile/data/models/credit_card_model.dart';
import 'package:i_watt_app/features/profile/data/models/payment_status_model.dart';

abstract class PaymentsDataSource {
  Future<GenericPagination<CreditCardModel>> getCreditCards({String? next});
  Future<CreateCreditCardModel> createCreditCard({required String cardNumber, required String expireDate});
  Future<void> confirmCreditCard({required String otp, required String cardToken});
  Future<void> deleteCreditCard({required int userCardId});
  Future<void> payWithCard({required int cardId, required int amount});
}

class PaymentsDataSourceImpl extends PaymentsDataSource {
  final Dio dio;

  PaymentsDataSourceImpl({required this.dio});

  @override
  Future<GenericPagination<CreditCardModel>> getCreditCards({String? next}) async {
    try {
      final response = await dio.get(
        next ?? 'payment/UserCardList/',
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
  Future<CreateCreditCardModel> createCreditCard({required String cardNumber, required String expireDate}) async {
    try {
      final response = await dio.post(
        '/payment/CardCreate/',
        data: {"card_number": cardNumber, "expire_date": expireDate},
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return CreateCreditCardModel.fromJson(response.data);
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
  Future<void> confirmCreditCard({required String otp, required String cardToken}) async {
    try {
      final response = await dio.post(
        '/payment/CardVerify/$cardToken/',
        data: {
          "code": otp,
        },
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
        'payment/CardDelete/$userCardId/',
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
