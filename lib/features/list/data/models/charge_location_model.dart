import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/station_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charge_location_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChargeLocationModel extends ChargeLocationEntity {
  factory ChargeLocationModel.fromJson(Map<String, dynamic> json) => _$ChargeLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargeLocationModelToJson(this);

  const ChargeLocationModel({
    super.longitude,
    super.latitude,
    super.chargePoints,
    super.id,
    super.region,
    super.name,
    super.address,
    super.landmark,
    super.regionName,
    super.isFavorite,
  });
}
