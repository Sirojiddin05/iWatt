import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/in_progress_charing_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'in_progress_charging_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InProgressChargingModel extends InProgressChargingEntity {
  const InProgressChargingModel({
    super.batteryPercent,
    super.connector,
    super.consumedKwh,
    super.id,
    super.locationName,
    super.money,
    super.startCommandId,
    super.vendorName,
    super.freeParkingMinutes,
    super.parkingPrice,
    super.parkingStartTime,
    super.status,
  });

  factory InProgressChargingModel.fromJson(Map<String, dynamic> json) => _$InProgressChargingModelFromJson(json);
}
