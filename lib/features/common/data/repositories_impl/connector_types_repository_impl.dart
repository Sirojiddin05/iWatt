import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/datasources/connector_types_datasource.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/connector_types_repository.dart';

class ConnectorTypesRepositoryImpl implements ConnectorTypesRepository {
  final ConnectorTypesDataSource _datasource;

  const ConnectorTypesRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, GenericPagination<IdNameEntity>>> getConnectorTypes() async {
    try {
      final result = await _datasource.getConnectorTypes();
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
