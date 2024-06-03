import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/navigation/data/models/version_features_model.dart';
import 'package:i_watt_app/features/navigation/data/models/version_model.dart';

abstract class VersionCheckDataSource {
  Future<VersionModel> getAppLatestVersion();

  Future<GenericPagination<VersionFeaturesModel>> getVersionFeatures(int versionId);

// Future<>
}

class VersionCheckDataSourceImpl implements VersionCheckDataSource {
  final Dio dio;

  VersionCheckDataSourceImpl(this.dio);

  @override
  Future<VersionModel> getAppLatestVersion() async {
    try {
      final response = await dio.get(
        'common/LastVersion/${Platform.isIOS ? 'ios' : 'android'}/',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return VersionModel.fromJson(response.data);
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
  Future<GenericPagination<VersionFeaturesModel>> getVersionFeatures(int versionId) async {
    try {
      final response = await dio.get('common/VersionFeatures/', queryParameters: {'version_id': versionId});
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(
            response.data, (p0) => VersionFeaturesModel.fromJson(p0 as Map<String, dynamic>));
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
