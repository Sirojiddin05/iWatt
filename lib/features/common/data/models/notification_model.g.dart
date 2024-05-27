// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      title: json['title'] as String? ?? '',
      addTime: json['add_time'] as String? ?? '',
      seenTime: json['seen_time'] as String? ?? '',
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'add_time': instance.addTime,
      'seen_time': instance.seenTime,
    };
