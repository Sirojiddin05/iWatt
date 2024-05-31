import 'package:i_watt_app/features/charge_location_single/data/models/connector_standart_model.dart';
import 'package:json_annotation/json_annotation.dart';

class ConnectorStandardEntity {
  final int id;
  final String name;
  final String icon;
  final int maxVoltage;
  @JsonKey(name: '_type', defaultValue: '')
  final String type;

  const ConnectorStandardEntity({
    this.id = -1,
    this.name = '',
    this.icon = '',
    this.maxVoltage = -1,
    this.type = '',
  });
}

class ConnectorStandardConverter implements JsonConverter<ConnectorStandardEntity, Map<String, dynamic>> {
  const ConnectorStandardConverter();

  @override
  ConnectorStandardEntity fromJson(Map<String, dynamic> json) => ConnectorStandardModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(ConnectorStandardEntity object) => {};
}
