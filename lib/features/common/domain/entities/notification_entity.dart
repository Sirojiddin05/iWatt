import 'package:i_watt_app/features/common/data/models/notification_model.dart';
import 'package:json_annotation/json_annotation.dart';

class NotificationEntity {
  const NotificationEntity({
    this.id = -1,
    this.title = '',
    this.description = '',
    this.photo = '',
    this.createdAt = '',
    this.isRead = false,
  });

  final int id;
  final String title;
  final String description;
  final String photo;
  final String createdAt;
  final bool isRead;

  NotificationEntity copyWith({
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id,
      title: title,
      description: description,
      photo: photo,
      createdAt: createdAt,
      isRead: isRead ?? this.isRead,
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
