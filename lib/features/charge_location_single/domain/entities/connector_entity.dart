import 'package:i_watt_app/features/charge_location_single/data/models/connector_model.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_standard.dart';
import 'package:json_annotation/json_annotation.dart';

class ConnectorEntity {
  const ConnectorEntity({
    this.id = -1,
    this.name = '',
    this.status = '',
    this.standard = const ConnectorStandardEntity(),
  });

  final int id;
  final String name;
  final String status;
  @ConnectorStandardConverter()
  final ConnectorStandardEntity standard;

  ConnectorEntity copyWith({
    String? name,
    String? status,
    ConnectorStandardEntity? standard,
  }) {
    return ConnectorEntity(
      id: id,
      name: name ?? this.name,
      status: status ?? this.status,
      standard: standard ?? this.standard,
    );
  }
}

class ConnectorConverter implements JsonConverter<ConnectorEntity, Map<String, dynamic>> {
  const ConnectorConverter();

  @override
  ConnectorEntity fromJson(Map<String, dynamic> json) => ConnectorModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(ConnectorEntity object) => {};
}
