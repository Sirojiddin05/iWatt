import 'package:i_watt_app/features/common/domain/entities/about_us_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'about_us_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AboutUsModel extends AboutUsEntity {
  const AboutUsModel({super.title, super.content});

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => _$AboutUsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);
}
