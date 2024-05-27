import 'package:i_watt_app/features/common/domain/entities/notification_detail_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationDetailModel extends NotificationDetailEntity {
  const NotificationDetailModel({
    super.data,
  });

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) => _$NotificationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDetailModelToJson(this);
}
