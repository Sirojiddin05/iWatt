import 'package:i_watt_app/features/list/data/models/station_model.dart';
import 'package:i_watt_app/features/list/domain/entities/connector_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class StationEntity {
  final int id;
  final String name;
  final String model;
  final String vendor;
  final String serialNumber;
  final String firmware;
  final String type;
  final String lastHeartbeat;
  final String bootTimestamp;
  final String identity;
  final bool connected;
  final bool status;
  @ConnectorConverter()
  final List<ConnectorEntity> connectors;
  final bool isReservationEnabled;

  const StationEntity({
    this.id = -1,
    this.name = '',
    this.model = '',
    this.vendor = '',
    this.serialNumber = '',
    this.firmware = '',
    this.type = '',
    this.lastHeartbeat = '',
    this.bootTimestamp = '',
    this.identity = '',
    this.connected = false,
    this.status = false,
    this.connectors = const [],
    this.isReservationEnabled = false,
  });
}

class StationConverter implements JsonConverter<StationEntity, Map<String, dynamic>> {
  const StationConverter();

  @override
  StationEntity fromJson(Map<String, dynamic> json) => StationModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(StationEntity object) => {};
}
