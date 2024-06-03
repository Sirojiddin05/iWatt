import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/in_progress_charing_entity.dart';
import 'package:i_watt_app/features/charging_processes/data/datasource/charging_process_datasource.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_param_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_response_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/repositories/charging_process_repository.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';

class ChargingProcessRepositoryImpl extends ChargingProcessRepository {
  final ChargingProcessDataSource dataSource;

  ChargingProcessRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, CommandResultResponseEntity>> startChargingProcess({required StartProcessParamEntity params}) async {
    try {
      final result = await dataSource.startChargingProcess(params: params);
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
  Future<Either<Failure, CommandResultResponseEntity>> stopChargingProcess({required int transaction}) async {
    try {
      final result = await dataSource.stopChargingProcess(transactionId: transaction);
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
  Future<Either<Failure, GenericPagination<InProgressCharingEntity>>> getChargingProcesses() async {
    try {
      final result = await dataSource.getChargingProcesses();
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
