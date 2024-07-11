import 'package:i_watt_app/features/common/domain/entities/location_filter_key_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_filter_key_model.g.dart';

@JsonSerializable()
class LocationFilterKeyModel extends LocationFilterKeyEntity {
  const LocationFilterKeyModel({
    super.id,
    super.icon,
    super.title,
    super.key,
  });

  factory LocationFilterKeyModel.fromJson(Map<String, dynamic> json) => _$LocationFilterKeyModelFromJson(json);
}
