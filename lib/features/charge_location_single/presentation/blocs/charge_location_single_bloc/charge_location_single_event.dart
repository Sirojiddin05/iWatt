part of 'charge_location_single_bloc.dart';

abstract class ChargeLocationSingleEvent {
  const ChargeLocationSingleEvent();
}

class GetLocationSingle extends ChargeLocationSingleEvent {
  final int id;
  const GetLocationSingle(this.id);
}

class ChangeSelectedStationIndexByConnectorId extends ChargeLocationSingleEvent {
  final int connectorId;
  const ChangeSelectedStationIndexByConnectorId(this.connectorId);
}

class ChangeSelectedStationIndex extends ChargeLocationSingleEvent {
  final int index;
  const ChangeSelectedStationIndex(this.index);
}

class SetIsNearToStation extends ChargeLocationSingleEvent {
  final bool isNearToStation;
  const SetIsNearToStation(this.isNearToStation);
}

class ChangeConnectorStatus extends ChargeLocationSingleEvent {
  final int connectorId;
  final String status;
  const ChangeConnectorStatus({required this.connectorId, required this.status});
}

class ChangeSavedStateOfLocation extends ChargeLocationSingleEvent {
  final bool saved;
  const ChangeSavedStateOfLocation({required this.saved});
}
