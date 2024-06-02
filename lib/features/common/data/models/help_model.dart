import 'package:i_watt_app/features/common/domain/entities/help_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'help_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HelpModel extends HelpEntity {
  const HelpModel({
    super.helpEmail,
    super.helpPhoneNumber,
    super.helpTelegramLink,
  });

  factory HelpModel.fromJson(Map<String, dynamic> json) => _$HelpModelFromJson(json);

  Map<String, dynamic> toJson() => _$HelpModelToJson(this);
}
