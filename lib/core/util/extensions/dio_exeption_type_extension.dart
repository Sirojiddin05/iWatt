import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

extension DioExceptionExtension on DioExceptionType {
  bool get isConnectionError {
    if (this == DioExceptionType.connectionTimeout) {
      return true;
    }
    if (this == DioExceptionType.sendTimeout) {
      return true;
    }
    if (this == DioExceptionType.receiveTimeout) {
      return true;
    }
    if (this == DioExceptionType.connectionError) {
      return true;
    }
    return false;
  }

  bool get isServerError {
    if (this == DioExceptionType.badResponse) {
      return true;
    }
    if (this == DioExceptionType.badCertificate) {
      return true;
    }
    if (this == DioExceptionType.unknown) {
      return true;
    }
    return false;
  }

  String get message {
    if (isConnectionError) {
      return LocaleKeys.check_connection.tr();
    } else if (isServerError) {
      return LocaleKeys.server_problems.tr();
    } else {
      return LocaleKeys.request_canceled.tr();
    }
  }
}
