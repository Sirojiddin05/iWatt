import 'package:i_watt_app/features/charge_location_single/domain/entities/charger_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charger_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChargerModel extends ChargerEntity {
  ChargerModel({
    super.id,
    super.connectors,
    super.bookingPrice,
    super.chargerId,
    super.isConnected,
    super.maxElectricPower,
    super.name,
    super.parkingPrice,
    super.price,
  });

  factory ChargerModel.fromJson(Map<String, dynamic> json) => _$ChargerModelFromJson(json);
}
