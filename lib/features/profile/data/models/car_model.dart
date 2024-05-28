import 'package:i_watt_app/features/profile/domain/entities/car_model_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CarModel extends CarEntity {
  const CarModel({
    super.id,
    super.name,
    super.model,
    super.typeStateNumber,
    super.chargingType,
    super.vehicleType,
    super.vin,
    super.manufacturer,
    super.stateNumber,
    super.customManufacturer,
    super.chargingTypeName,
    super.typeStateNumberName,
    super.vehicleTypeName,
    super.usableBatterySize,
    super.brand,
    super.releaseYear,
    super.variant,
    super.modelName,
    super.version,
    super.icon,
    super.modelManifacturer,
    super.customModel,
  });
  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
