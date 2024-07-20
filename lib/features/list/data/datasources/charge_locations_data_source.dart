import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/get_charge_locations_param_entity.dart';

abstract class ChargeLocationsDataSource {
  Future<GenericPagination<ChargeLocationModel>> getChargeLocations(
      {required GetChargeLocationParamEntity paramEntity});
  Future<void> saveUnSaveChargeLocation({required int id});
}

class ChargeLocationsDataSourceImpl implements ChargeLocationsDataSource {
  final Dio _dio;

  const ChargeLocationsDataSourceImpl(this._dio);

  @override
  Future<GenericPagination<ChargeLocationModel>> getChargeLocations(
      {required GetChargeLocationParamEntity paramEntity}) async {
    late final String baseUrl;
    if (paramEntity.next.isNotEmpty) {
      baseUrl = paramEntity.next;
    } else if (paramEntity.isFavourite) {
      baseUrl = 'chargers/SavedLocationList/';
    } else {
      baseUrl = 'chargers/LocationList/';
    }
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: baseUrl != paramEntity.next ? paramEntity.toJson() : null,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
          response.data,
          (p0) {
            return ChargeLocationModel.fromJson(p0 as Map<String, dynamic>);
          },
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
  Future<void> saveUnSaveChargeLocation({required int id}) async {
    try {
      final response = await _dio.post(
        'common/SavedLocation/',
        data: {'location': id},
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
// import 'dart:convert';
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:http/http.dart' as http;
// final secretKey = encrypt.Key.fromUtf8('your-32-byte-secret-key');
// final ivLength = 16;
// String decryptData(String base64Encrypted) {
//   final decoded = base64Url.decode(base64Encrypted);
//   final salt = decoded.sublist(0, 16);
//   final iv = encrypt.IV(decoded.sublist(16, 16 + ivLength));
//   final encryptedData = decoded.sublist(16 + ivLength);
//   final keyDerivator = encrypt.KeyDerivator('SHA-256/HMAC/PBKDF2');
//   final key = keyDerivator.process(secretKey.bytes);
//   final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(key.toString())));
//   final decrypted = encrypter.decryptBytes(encrypt.Encrypted(encryptedData), iv: iv);
//   return utf8.decode(decrypted);
// }
// Future<void> fetchEncryptedData() async {
//   final response = await http.get(Uri.parse('https://yourdomain.com/my_view'));
//   if (response.statusCode == 200) {
//     final encryptedData = jsonDecode(response.body)['data'];
//     final decryptedData = decryptData(encryptedData);
//     print(decryptedData); // Use your decrypted data
//   } else {
//     throw Exception('Failed to load data');
//   }
// }
// void main() {
//   fetchEncryptedData();
// }
