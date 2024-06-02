import 'package:i_watt_app/core/error/exception_handler.dart';
import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/core/util/extensions/dio_exeption_type_extension.dart';
import 'package:i_watt_app/features/common/data/datasources/socket_datasource.dart';
import 'package:i_watt_app/features/common/domain/entities/command_result_message.dart';
import 'package:i_watt_app/features/common/domain/entities/connector_status_message.dart';
import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';
import 'package:i_watt_app/features/common/domain/repositories/socket_repository.dart';

class SocketRepositoryImpl extends SocketRepository {
  final SocketDataSource _dataSource;

  SocketRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, void>> connectToSocket() async {
    try {
      final result = await _dataSource.connectToSocket();
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
  Stream<ConnectorStatusMessageEntity> connectorStatusStream() async* {
    yield* _dataSource.connectorStatusStream();
  }

  @override
  Future<Either<Failure, void>> disconnectFromSocket() async {
    try {
      final result = await _dataSource.disconnectFromSocket();
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
  Stream<MeterValueMessageEntity> meterValueStream() async* {
    yield* _dataSource.meterValueStream();
  }

  @override
  Stream<CommandResultMessageEntity> startCommandResultStream() async* {
    yield* _dataSource.startCommandResultStream();
  }

  @override
  Stream<CommandResultMessageEntity> stopCommandResult() async* {
    yield* _dataSource.stopCommandResult();
  }

  @override
  Stream<TransactionMessageEntity> transactionChequeStream() async* {
    yield* _dataSource.transactionChequeStream();
  }
}
