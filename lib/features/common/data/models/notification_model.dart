import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationModel extends NotificationEntity {
  const NotificationModel({
    super.id,
    super.title,
    super.description,
    super.photo,
    super.isRead,
    super.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
