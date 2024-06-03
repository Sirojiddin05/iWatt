import 'package:i_watt_app/features/navigation/domain/entity/version_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VersionModel extends VersionEntity {
  const VersionModel({
    super.id,
    super.number,
    super.platformType,
    super.isForceUpdate,
  });

  factory VersionModel.fromJson(Map<String, dynamic> json) => _$VersionModelFromJson(json);
}
