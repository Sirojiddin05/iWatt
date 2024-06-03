part of 'charging_process_bloc.dart';

abstract class ChargingProcessEvent {}

class CreateChargingProcessEvent extends ChargingProcessEvent {
  final ConnectorEntity connector;

  CreateChargingProcessEvent(this.connector);
}

class DeleteChargingProcessEvent extends ChargingProcessEvent {
  final int index;

  DeleteChargingProcessEvent(this.index);
}

class UpdateMeterValueOfProcess extends ChargingProcessEvent {
  final MeterValueMessageEntity meterValue;

  UpdateMeterValueOfProcess(this.meterValue);
}

class StartChargingProcessEvent extends ChargingProcessEvent {
  final int connectionId;
  final bool isLimited;

  StartChargingProcessEvent({required this.connectionId, this.isLimited = false});
}

class StopChargingProcessEvent extends ChargingProcessEvent {
  final int transactionId;

  StopChargingProcessEvent({required this.transactionId});
}

class CreateTransactionCheque extends ChargingProcessEvent {
  final TransactionMessageEntity transactionCheque;

  CreateTransactionCheque(this.transactionCheque);
}

class ConnectToSocketEvent extends ChargingProcessEvent {
  ConnectToSocketEvent();
}

class DisconnectFromSocketEvent extends ChargingProcessEvent {
  DisconnectFromSocketEvent();
}

class GetChargingProcessesEvent extends ChargingProcessEvent {
  GetChargingProcessesEvent();
}
