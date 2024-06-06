import 'dart:async';
import 'dart:convert';

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

  SocketDataSourceImpl();

  @override
  Future<void> connectToSocket() async {
    print('Connecting to socket');
    final token = StorageRepository.getString(StorageKeys.accessToken).replaceAll('Bearer ', '');
    print('token: $token');
    final url = "wss://app.i-watt.uz/ws/v1/mobile/?token=$token";
    final wsUrl = Uri.parse(url);
    _channel = WebSocketChannel.connect(wsUrl);
    await _channel?.ready;
    _channel?.stream.listen((jsonMessage) {
      final message = jsonDecode(jsonMessage);
      final messageType = message["type"];
      final messageData = message["data"];
      if (messageType == SocketType.connector.name) {
        final connectorResult = ConnectorStatusMessageModel.fromJson(messageData);
        _connectorStatusStream.add(connectorResult);
      } else if (messageType == SocketType.command_result.name) {
        final commandResult = CommandResultMessageModel.fromJson(messageData);
        if (commandResult.commandType == 'REMOTE_START_TRANSACTION') {
          _startCommandResultStream.add(commandResult);
        } else if (commandResult.commandType == 'REMOTE_STOP_TRANSACTION') {
          _stopCommandResultStream.add(commandResult);
        }
      } else if (messageType == SocketType.meter_values_data.name) {
        final meterValue = MeterValueMessageModel.fromJson(messageData);
        _meterValueStream.add(meterValue);
      } else if (messageType == SocketType.parking_data.name) {
        print('parking_data');
        late final parkingData;
        try {
          parkingData = ParkingDataMessageModel.fromJson(messageData);
        } catch (e) {
          print('error $e');
        }
        print('parking_data1 $messageData');
        print('parking_data2 $messageData');
        _parkingDataStream.add(parkingData);
      } else if (messageType == SocketType.transaction_cheque.name) {
        late final transactionCheque;
        try {
          transactionCheque = TransactionMessageModel.fromJson(messageData);
        } catch (e) {
          print('error $e');
        }
        print('transaction_cheque $messageType');
        print('messageData $messageData');
        _transactionChequeStream.add(transactionCheque);
      }
    });
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
