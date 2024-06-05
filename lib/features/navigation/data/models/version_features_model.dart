import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_features_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VersionFeaturesModel extends VersionFeaturesEntity {
  const VersionFeaturesModel({
    super.id,
    super.version,
    super.title,
    super.description,
    super.file,
  });

  factory VersionFeaturesModel.fromJson(Map<String, dynamic> json) => _$VersionFeaturesModelFromJson(json);
}
