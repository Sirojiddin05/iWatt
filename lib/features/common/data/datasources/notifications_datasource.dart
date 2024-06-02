import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/data/models/notification_detail_model.dart';
import 'package:i_watt_app/features/common/data/models/notification_model.dart';

abstract class NotificationDataSource {
  Future<GenericPagination<NotificationModel>> getNotifications({String? next});

  Future<NotificationDetailModel> getNotificationDetail({required int id});

  Future<void> readAllNotifications();

  Future<void> notificationOnOff({required bool enabled});
}

class NotificationDataSourceImpl extends NotificationDataSource {
  final Dio _dio;

  NotificationDataSourceImpl(this._dio);

  @override
  Future<NotificationDetailModel> getNotificationDetail({required int id}) async {
    try {
      final response = await _dio.get(
        '/notification/UserNotificationDetail/$id/',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return NotificationDetailModel.fromJson(response.data);
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
  Future<GenericPagination<NotificationModel>> getNotifications({String? next}) async {
    try {
      final response = await _dio.get(
        next ?? '/notification/UserNotificationList/',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) => NotificationModel.fromJson(p0 as Map<String, dynamic>),
        );
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
  Future<void> readAllNotifications() async {
    try {
      final response = await _dio.post('/notification/UserNotificationReadAll/');
      if (!(response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300)) {
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
  Future<void> notificationOnOff({required bool enabled}) async {
    try {
      final response = await _dio.patch(
        'users/profile-update/',
        data: {"is_notification_enabled": enabled},
      );
      if (!(response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300)) {
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
