import 'package:i_watt_app/features/charge_location_single/domain/entities/appeal_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appeal_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppealModel extends AppealEntity {
  const AppealModel({
    super.id,
    super.title,
  });

  factory AppealModel.fromJson(Map<String, dynamic> json) => _$AppealModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppealModelToJson(this);
}
