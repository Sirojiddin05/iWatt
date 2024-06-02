import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/entities/command_result_message.dart';
import 'package:i_watt_app/features/common/domain/entities/connector_status_message.dart';
import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';
import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';

abstract class SocketRepository {
  Future<Either<Failure, void>> connectToSocket();
  Future<Either<Failure, void>> disconnectFromSocket();
  Stream<ConnectorStatusMessageEntity> connectorStatusStream();
  Stream<CommandResultMessageEntity> startCommandResultStream();
  Stream<MeterValueMessageEntity> meterValueStream();
  Stream<CommandResultMessageEntity> stopCommandResult();
  Stream<TransactionMessageEntity> transactionChequeStream();
}
