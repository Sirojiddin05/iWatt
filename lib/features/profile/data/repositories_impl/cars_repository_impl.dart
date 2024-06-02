import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/profile/data/datasources/cars_datasource.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:i_watt_app/features/profile/domain/repositories/cars_repository.dart';

class CarsRepositoryImpl extends CarsRepository {
  final CarsDatasource datasource;

  CarsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, GenericPagination<CarEntity>>> getCars() async {
    try {
      final result = await datasource.getCars();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> editCar({required CarEntity car}) async {
    try {
      final result = await datasource.editCar(car: car);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCar({required int id}) async {
    try {
      final result = await datasource.deleteCar(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> addCar({required CarEntity car}) async {
    try {
      final result = await datasource.addCar(car: car);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage));
    } on CustomDioException catch (e) {
      final message = e.type.message;
      return Left(DioFailure(errorMessage: message));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }
}
