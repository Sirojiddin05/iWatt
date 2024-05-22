import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id_name_model.g.dart';

@JsonSerializable()
class IdNameModel extends IdNameEntity {
  const IdNameModel({
    super.id,
    super.name,
    super.type,
  });

  factory IdNameModel.fromJson(Map<String, dynamic> json) => _$IdNameModelFromJson(json);
}
