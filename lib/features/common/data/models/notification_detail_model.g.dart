// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDetailModel _$NotificationDetailModelFromJson(
        Map<String, dynamic> json) =>
    NotificationDetailModel(
      data: json['data'] == null
          ? const NotificationEntity()
          : const NotificationConverter()
              .fromJson(json['data'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$NotificationDetailModelToJson(
        NotificationDetailModel instance) =>
    <String, dynamic>{
      'data': const NotificationConverter().toJson(instance.data),
    };
