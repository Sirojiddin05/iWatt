import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/navigation/data/datasources/version_check_datasource.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_entity.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';
import 'package:i_watt_app/features/navigation/domain/repositories/version_check_repository.dart';

class VersionCheckRepositoryImpl implements VersionCheckRepository {
  final VersionCheckDataSource dataSource;

  const VersionCheckRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, VersionEntity>> getAppLatestVersion() async {
    try {
      final result = await dataSource.getAppLatestVersion();
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
  Future<Either<Failure, GenericPagination<VersionFeaturesEntity>>> getVersionFeatures(int versionId) async {
    try {
      final result = await dataSource.getVersionFeatures(versionId);
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
