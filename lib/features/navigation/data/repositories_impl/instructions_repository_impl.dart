import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/navigation/data/datasources/instructions_datasource.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';
import 'package:i_watt_app/features/navigation/domain/repositories/instructions_repository.dart';

class InstructionsRepositoryImpl implements InstructionsRepository {
  final InstructionsDataSource dataSource;

  InstructionsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, GenericPagination<VersionFeaturesEntity>>> getInstructions(String type) async {
    try {
      final result = await dataSource.getInstructions(type);
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
