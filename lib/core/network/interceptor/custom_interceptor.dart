import 'package:dio/dio.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';

class CustomInterceptor implements Interceptor {
  final Dio dio;

  const CustomInterceptor({required this.dio});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.badResponse && (err.response?.statusCode == 403 || err.response?.statusCode == 401)) {
      StorageRepository.deleteString(StorageKeys.accessToken);
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
    if (StorageRepository.getString(StorageKeys.accessToken, defValue: '').isNotEmpty) {
      options.headers['Authorization'] = StorageRepository.getString(StorageKeys.accessToken);
    } else {
      options.headers.remove('Authorization');
    }
    options.headers['Accept-Language'] = StorageRepository.getString(AppConstants.language, defValue: 'uz');
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 403 || response.statusCode == 401) {
      if (StorageRepository.getString(StorageKeys.refreshToken).isEmpty) {
        handler.next(response);
        return;
      }
      await _refreshToken(response.requestOptions.baseUrl);
      if (StorageRepository.getString(StorageKeys.accessToken).replaceAll('Bearer', '').trim().isNotEmpty) {
        response.requestOptions.headers['Authorization'] = StorageRepository.getString(StorageKeys.accessToken);
      }
      final resolved = await _resolveResponse(response.requestOptions);
      handler.resolve(resolved);
      return;
    }
    handler.next(response);
  }

  Future<void> _refreshToken(String baseUrl) async {
    if (StorageRepository.getString(StorageKeys.refreshToken).isNotEmpty) {
      final response = await dio.post('$baseUrl/users/TokenRefresh/', data: {"refresh": StorageRepository.getString(StorageKeys.refreshToken)});
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        StorageRepository.putString(StorageKeys.accessToken, 'Bearer ${response.data['access']}');
      } else {
        StorageRepository.deleteString(StorageKeys.accessToken);
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
        formData.files.add(MapEntry(
            mapFile.key,
            MultipartFile.fromFileSync(
                fields
                    .firstWhere(
                      (element) => element.key == 'photo_path',
                      orElse: () => const MapEntry('', ''),
                    )
                    .value,
                filename: mapFile.value.filename)));
      }
      options.data = formData;
    }
    return await dio.request(AppConstants.baseUrl + path,
        data: options.data,
        queryParameters: options.queryParameters,
        options: Options(
          headers: options.headers,
          method: options.method,
        ));
  }
}
