import 'package:i_watt_app/features/list/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/station_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StationModel extends StationEntity {
  const StationModel({
    super.bootTimestamp,
    super.connected,
    super.connectors,
    super.firmware,
    super.id,
    super.identity,
    super.lastHeartbeat,
    super.model,
    super.name,
    super.serialNumber,
    super.status,
    super.type,
    super.vendor,
    super.isReservationEnabled,
  });
  factory StationModel.fromJson(Map<String, dynamic> json) => _$StationModelFromJson(json);
}
