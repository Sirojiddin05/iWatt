import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charge_location_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChargeLocationModel extends ChargeLocationEntity {
  const ChargeLocationModel({
    super.longitude,
    super.latitude,
    super.id,
    super.address,
    super.connectorsCount,
    super.connectorsStatus,
    super.distance,
    super.vendorName,
    super.locationName,
    super.isFavorite,
    super.chargersCount,
    super.logo,
    super.maxElectricPowers,
    super.locationAppearance,
    super.status,
  });
  factory ChargeLocationModel.fromJson(Map<String, dynamic> json) => _$ChargeLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargeLocationModelToJson(this);
}
