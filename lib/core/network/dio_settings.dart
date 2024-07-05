import 'package:dio/dio.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/network/interceptor/token_refresh.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';

class DioSettings {
  BaseOptions _dioBaseOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 35),
    receiveTimeout: const Duration(seconds: 33),
    followRedirects: false,
    headers: <String, dynamic>{
      'Accept-Language': StorageRepository.getString(StorageKeys.currentLanguage, defValue: 'uz'),
    },
    validateStatus: (status) => status != null && status <= 500,
  );

  void setBaseOptions({String? lang}) {
    _dioBaseOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 35),
      receiveTimeout: const Duration(seconds: 33),
      headers: <String, dynamic>{'Accept-Language': lang},
      followRedirects: false,
      validateStatus: (status) => status != null && status <= 500,
    );
  }

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  Dio get dio {
    final dio = Dio(_dioBaseOptions);
    dio.interceptors.addAll(
      [
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          request: true,
          requestHeader: true,
          logPrint: (object) => print(object.toString()),
        ),
        TokenRefreshInterceptor(dio: dio)
      ],
    );
    return dio;
  }
}
