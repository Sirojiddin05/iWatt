import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/profile/data/datasources/car_brands_datasource.dart';
import 'package:i_watt_app/features/profile/domain/repositories/car_brand_repository.dart';

class CarBrandsRepositoryImpl implements CarBrandsRepository {
  final CarBrandsDatasource datasource;

  CarBrandsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> getManufacturers({String searchQuery = '', String next = ''}) async {
    try {
      final result = await datasource.getManufacturers(next: next, searchQuery: searchQuery);
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
  Future<Either<Failure, GenericPagination<IdNameEntity>>> getModels({required int manufacturerId, String next = ''}) async {
    try {
      final result = await datasource.getModels(manufacturerId: manufacturerId, next: next);
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
