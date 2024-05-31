import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_standard.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connector_standart_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConnectorStandardModel extends ConnectorStandardEntity {
  ConnectorStandardModel({
    super.id,
    super.name,
    super.icon,
    super.maxVoltage,
    super.type,
  });

  factory ConnectorStandardModel.fromJson(Map<String, dynamic> json) => _$ConnectorStandardModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectorStandardModelToJson(this);
}
