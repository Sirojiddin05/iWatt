import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_standard.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connector_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConnectorModel extends ConnectorEntity {
  const ConnectorModel({
    super.id,
    super.name,
    super.standard,
    super.status,
    super.price,
    super.parkingPrice,
    super.maxElectricPower,
  });
  factory ConnectorModel.fromJson(Map<String, dynamic> json) => _$ConnectorModelFromJson(json);
}
