import 'package:dio/dio.dart';
import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/features/common/data/models/error_model.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/data/models/car_model.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';

abstract class CarsDatasource {
  Future<int> addCar({required CarEntity car});
  Future<void> deleteCar({required int id});
  Future<void> editCar({required CarEntity car});
  Future<GenericPagination<CarEntity>> getCars();
}

class CarsDatasourceImpl extends CarsDatasource {
  final Dio _dio;

  CarsDatasourceImpl(Dio this._dio);

  @override
  Future<GenericPagination<CarModel>> getCars() async {
    try {
      final response = await _dio.get(
        'core/cars/',
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson({'results': response.data['data']}, (p0) => CarModel.fromJson(p0 as Map<String, dynamic>));
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.error,
          error: error.error,
        );
      }
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<int> addCar({required CarEntity car}) async {
    Map<String, dynamic> data = car.toApi();
    try {
      final response = await _dio.post(
        'core/cars/',
        data: data,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data['id'];
      } else {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<CarModel> editCar({required CarEntity car}) async {
    try {
      final response = await _dio.put(
        'core/cars/edit/${car.id}/',
        data: car.toApi(),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return CarModel.fromJson(response.data);
      } else {
        final error = GenericErrorModel.fromJson(response.data);

        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> deleteCar({required int id}) async {
    try {
      final response = await _dio.post(
        'core/car/delete/',
        data: {"car_id": id},
      );
      if (!(response.statusCode! >= 200 && response.statusCode! < 300)) {
        final error = GenericErrorModel.fromJson(response.data);
        throw ServerException(
          statusCode: error.statusCode,
          errorMessage: error.message,
          error: error.error,
        );
      }
    } on DioException catch (e) {
      final type = e.type;
      final message = e.message ?? '';
      throw CustomDioException(errorMessage: message, type: type);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
