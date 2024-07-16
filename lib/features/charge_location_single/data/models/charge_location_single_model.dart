import 'package:i_watt_app/features/charge_location_single/domain/entities/charge_location_single_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/charger_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/vendor_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charge_location_single_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChargeLocationSingleModel extends ChargeLocationSingleEntity {
  const ChargeLocationSingleModel({
    super.id,
    super.name,
    super.distance,
    super.address,
    super.chargers,
    super.isFavorite,
    super.vendor,
    super.facilities,
    super.latitude,
    super.longitude,
  });

  factory ChargeLocationSingleModel.fromJson(Map<String, dynamic> json) => _$ChargeLocationSingleModelFromJson(json);
}
