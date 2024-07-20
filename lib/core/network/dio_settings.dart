import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/network/interceptor/token_refresh.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';

class DioSettings {
  // late final HttpClient _httpClient;
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

  // Future<void> initSecurityContext() async {
  //   final context = await MyFunctions.globalContext;
  //   _httpClient = HttpClient(context: context);
  // }

  Dio get dio {
    final dio = Dio(
      _dioBaseOptions,
    );
    // dio.httpClientAdapter = IOHttpClientAdapter()..createHttpClient = () => _httpClient;
    dio.interceptors.addAll(
      [
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          request: true,
          requestHeader: true,
          logPrint: (object) {
            if (kDebugMode) {
              log(object.toString());
            }
          },
        ),
        TokenRefreshInterceptor(dio: dio),
      ],
    );

    return dio;
  }
}
