import 'package:i_watt_app/features/common/domain/entities/about_us_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'about_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AboutUsModel extends AboutUsEntity {
  const AboutUsModel({
    super.description,
    super.phone,
    super.botUsername,
    super.email,
    super.title,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => _$AboutUsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);
}
