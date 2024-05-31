import 'package:i_watt_app/features/profile/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.fullName,
    super.phone,
    super.photo,
    super.dateOfBirth,
    super.language,
    super.notificationCount,
    super.isNotificationEnabled,
    super.balance,
    super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
