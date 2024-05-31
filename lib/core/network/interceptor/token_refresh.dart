import 'package:dio/dio.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';

class TokenRefreshInterceptor implements Interceptor {
  final Dio dio;

  const TokenRefreshInterceptor({required this.dio});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.badResponse && (err.response?.statusCode == 403)) {
      await StorageRepository.deleteString(StorageKeys.accessToken);
      await _refreshToken(err.requestOptions.baseUrl);
      if (StorageRepository.getString(StorageKeys.accessToken).replaceAll('Bearer', '').trim().isNotEmpty) {
        err.requestOptions.headers['Authorization'] = StorageRepository.getString(StorageKeys.accessToken);
      }
      final response = await _resolveResponse(err.requestOptions);
      handler.resolve(response);
      return;
    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = StorageRepository.getString(StorageKeys.accessToken);
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = accessToken;
    } else {
      options.headers.remove('Authorization');
    }
    options.headers['Accept-Language'] = StorageRepository.getString(StorageKeys.currentLanguage, defValue: 'uz');
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    final refreshToken = StorageRepository.getString(StorageKeys.refreshToken);
    if (response.statusCode == 403) {
      if (refreshToken.isEmpty) {
        handler.next(response);
        return;
      }
      await _refreshToken(response.requestOptions.baseUrl);
      final accessToken = StorageRepository.getString(StorageKeys.accessToken);
      final isTokenRefreshed = accessToken.replaceAll('Bearer', '').trim().isNotEmpty;
      if (isTokenRefreshed) {
        response.requestOptions.headers['Authorization'] = accessToken;
      }
      final resolved = await _resolveResponse(response.requestOptions);
      handler.resolve(resolved);
      return;
    }
    handler.next(response);
  }

  Future<void> _refreshToken(String baseUrl) async {
    if (StorageRepository.getString(StorageKeys.refreshToken).isNotEmpty) {
      final refreshToken = StorageRepository.getString(StorageKeys.refreshToken);
      final response = await dio.post(
        '${baseUrl}users/token/refresh/',
        data: {"refresh": refreshToken},
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        await StorageRepository.putString(StorageKeys.accessToken, 'Bearer ${response.data[StorageKeys.accessToken]}');
      } else {
        await StorageRepository.deleteString(StorageKeys.accessToken);
        if (response.statusCode == 401) {
          await StorageRepository.deleteString(StorageKeys.refreshToken);
        }
      }
    }
  }

  Future<Response<dynamic>> _resolveResponse(RequestOptions options) async {
    final path = options.path.replaceAll(AppConstants.baseUrl, '');
    if (options.data is FormData) {
      FormData formData = FormData();
      final fields = options.data.fields as List<MapEntry<String, String>>;
      formData.fields.addAll(fields);

      for (MapEntry mapFile in options.data.files) {
        formData.files.add(
          MapEntry(
            mapFile.key,
            MultipartFile.fromFileSync(
              fields
                  .firstWhere(
                    (element) => element.key == 'photo_path',
                    orElse: () => const MapEntry('', ''),
                  )
                  .value,
              filename: mapFile.value.filename,
            ),
          ),
        );
      }
      options.data = formData;
    }
    return await dio.request(
      AppConstants.baseUrl + path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(
        headers: options.headers,
        method: options.method,
      ),
    );
  }
}
