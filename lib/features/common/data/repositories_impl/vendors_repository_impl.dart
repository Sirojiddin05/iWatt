import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/datasources/vendors_datasource.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/vendors_repository.dart';

class VendorsRepositoryImpl extends VendorsRepository {
  final VendorsDatasource _datasource;

  VendorsRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> getVendors({String next = '', String searchPattern = ''}) async {
    try {
      final result = await _datasource.getVendors(next: next, searchPattern: searchPattern);
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
