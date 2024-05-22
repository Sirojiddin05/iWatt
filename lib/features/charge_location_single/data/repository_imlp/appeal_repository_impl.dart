import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/charge_location_single/data/datasources/appeal_datasource.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/appeal_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/repositories/appeal_repository.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';

class AppealRepositoryImpl extends AppealRepository {
  final AppealDataSource _datasource;

  AppealRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, GenericPagination<AppealEntity>>> getAppeals({required String next}) async {
    try {
      final result = await _datasource.getAppeals(next: next);
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
  Future<Either<Failure, void>> sendAppeal({required int id, required int location, String otherAppeal = ''}) async {
    try {
      final result = await _datasource.sendAppeal(id: id, location: location, otherAppeal: otherAppeal);
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
