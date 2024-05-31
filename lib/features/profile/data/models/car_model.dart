import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CarModel extends CarEntity {
  const CarModel({
    super.id,
    super.model,
    super.stateNumberType,
    super.vin,
    super.manufacturer,
    super.stateNumber,
    super.connectorType,
  });
  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
