part of 'charging_process_bloc.dart';

abstract class ChargingProcessEvent {}

class CreateChargingProcessEvent extends ChargingProcessEvent {
  final String locationName;
  final ConnectorEntity connector;

  CreateChargingProcessEvent(this.connector, {required this.locationName});
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

class ChargingProcessStartedEvent extends ChargingProcessEvent {
  final CommandResultMessageEntity commandMessage;

  ChargingProcessStartedEvent(this.commandMessage);
}

class ChargingProcessStoppedEvent extends ChargingProcessEvent {
  final CommandResultMessageEntity commandMessage;

  ChargingProcessStoppedEvent(this.commandMessage);
}

class SetParkingStateOfChargingProcess extends ChargingProcessEvent {
  final ParkingDataMessageEntity parkingData;

  SetParkingStateOfChargingProcess(this.parkingData);
}

class UpdatePayedParkingTimeEvent extends ChargingProcessEvent {
  final int transactionId;
  final int payedParkingTime;
  final int? price;

  UpdatePayedParkingTimeEvent({required this.payedParkingTime, required this.transactionId, this.price});
}

class UpdateFreeParkingTimeEvent extends ChargingProcessEvent {
  final int payedParkingWillStartAfter;
  final int transactionId;

  UpdateFreeParkingTimeEvent(this.payedParkingWillStartAfter, this.transactionId);
}

class SetFreeParkingPeriodTimer extends ChargingProcessEvent {
  final int transactionId;
  final int leftSeconds;

  SetFreeParkingPeriodTimer(this.leftSeconds, this.transactionId);
}

class SetPayedParkingPeriodTimer extends ChargingProcessEvent {
  final int transactionId;
  final int leftSeconds;

  SetPayedParkingPeriodTimer(this.transactionId, this.leftSeconds);
}

class DeleteAllProcesses extends ChargingProcessEvent {
  DeleteAllProcesses();
}
