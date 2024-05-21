import 'package:i_watt_app/features/list/domain/entities/address_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/price_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connector_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConnectorModel extends ConnectorEntity {
  const ConnectorModel(
      {super.chargePoint,
      super.connectorId,
      super.icon,
      super.id,
      super.name,
      super.powerName,
      super.price,
      super.status,
      super.typeConnection,
      super.typeConnectionName,
      super.address});
  factory ConnectorModel.fromJson(Map<String, dynamic> json) => _$ConnectorModelFromJson(json);
}
