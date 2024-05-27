import 'package:i_watt_app/features/common/data/models/notification_model.dart';
import 'package:json_annotation/json_annotation.dart';

class NotificationEntity {
  const NotificationEntity({
    this.id = -1,
    this.title = '',
    this.seenTime = '',
    this.addTime = '',
  });

  final int id;
  final String title;
  final String addTime;
  final String seenTime;

  NotificationEntity copyWith({
    String? seenTime,
  }) {
    return NotificationEntity(
      id: id,
      title: title,
      addTime: addTime,
      seenTime: seenTime ?? this.seenTime,
    );
  }
}

class NotificationConverter<S> implements JsonConverter<NotificationEntity, Map<String, dynamic>?> {
  const NotificationConverter();

  @override
  NotificationModel fromJson(Map<String, dynamic>? json) => NotificationModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(NotificationEntity object) => this.toJson(object);
}
