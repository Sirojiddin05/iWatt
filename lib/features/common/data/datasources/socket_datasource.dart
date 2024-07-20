import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/socket_message_type.dart';
import 'package:i_watt_app/features/common/data/models/command_result_message_model.dart';
import 'package:i_watt_app/features/common/data/models/connector_status_message_model.dart';
import 'package:i_watt_app/features/common/data/models/meter_value_message_model.dart';
import 'package:i_watt_app/features/common/data/models/parking_data_message_model.dart';
import 'package:i_watt_app/features/common/data/models/transaction_message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class SocketDataSource {
  Future<void> connectToSocket();
  Future<void> disconnectFromSocket();
  Stream<ConnectorStatusMessageModel> connectorStatusStream();
  Stream<CommandResultMessageModel> startCommandResultStream();
  Stream<MeterValueMessageModel> meterValueStream();
  Stream<ParkingDataMessageModel> parkingDataStream();
  Stream<CommandResultMessageModel> stopCommandResult();
  Stream<TransactionMessageModel> transactionChequeStream();
}

class SocketDataSourceImpl implements SocketDataSource {
  final StreamController<ConnectorStatusMessageModel> _connectorStatusStream = StreamController.broadcast(sync: true);
  final StreamController<CommandResultMessageModel> _startCommandResultStream = StreamController.broadcast(sync: true);
  final StreamController<MeterValueMessageModel> _meterValueStream = StreamController.broadcast(sync: true);
  final StreamController<ParkingDataMessageModel> _parkingDataStream = StreamController.broadcast(sync: true);
  final StreamController<CommandResultMessageModel> _stopCommandResultStream = StreamController.broadcast(sync: true);
  final StreamController<TransactionMessageModel> _transactionChequeStream = StreamController.broadcast(sync: true);

  WebSocketChannel? _channel;
  bool isReconnecting = false;

  SocketDataSourceImpl();

  @override
  Future<void> connectToSocket() async {
    final token = StorageRepository.getString(StorageKeys.accessToken).replaceAll('Bearer ', '');
    log('token $token');
    final url = "wss://app.i-watt.uz/ws/v1/mobile/?token=$token";
    final wsUrl = Uri.parse(url);
    _channel = WebSocketChannel.connect(wsUrl);
    try {
      await _channel?.ready;
      _channel?.stream.listen(
        (jsonMessage) {
          final message = jsonDecode(jsonMessage);
          final messageType = message["type"];
          final messageData = message["data"];
          if (messageType == SocketType.connector.name) {
            _connectorStatusStream.add(ConnectorStatusMessageModel.fromJson(messageData));
          } else if (messageType == SocketType.command_result.name) {
            final commandResult = CommandResultMessageModel.fromJson(messageData);
            if (commandResult.commandType == 'REMOTE_START_TRANSACTION') {
              _startCommandResultStream.add(commandResult);
            } else if (commandResult.commandType == 'REMOTE_STOP_TRANSACTION') {
              _stopCommandResultStream.add(commandResult);
            }
          } else if (messageType == SocketType.meter_values_data.name) {
            _meterValueStream.add(MeterValueMessageModel.fromJson(messageData));
          } else if (messageType == SocketType.parking_data.name) {
            _parkingDataStream.add(ParkingDataMessageModel.fromJson(messageData));
          } else if (messageType == SocketType.transaction_cheque.name) {
            _transactionChequeStream.add(TransactionMessageModel.fromJson(messageData));
          }
        },
        onError: (error) {
          reconnect();
        },
        onDone: () {
          reconnect();
        },
      );
    } catch (e) {}
  }

  void reconnect() {
    if (!isReconnecting) {
      isReconnecting = true;
      Future.delayed(const Duration(seconds: 3), () {
        isReconnecting = false;
        connectToSocket();
      });
    }
  }

  @override
  Stream<ConnectorStatusMessageModel> connectorStatusStream() async* {
    yield* _connectorStatusStream.stream;
  }

  @override
  Stream<CommandResultMessageModel> startCommandResultStream() async* {
    yield* _startCommandResultStream.stream;
  }

  @override
  Stream<MeterValueMessageModel> meterValueStream() async* {
    yield* _meterValueStream.stream;
  }

  @override
  Stream<ParkingDataMessageModel> parkingDataStream() async* {
    yield* _parkingDataStream.stream;
  }

  @override
  Stream<CommandResultMessageModel> stopCommandResult() async* {
    yield* _stopCommandResultStream.stream;
  }

  @override
  Stream<TransactionMessageModel> transactionChequeStream() async* {
    yield* _transactionChequeStream.stream;
  }

  @override
  Future<void> disconnectFromSocket() async {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }
}
