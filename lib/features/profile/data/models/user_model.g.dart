// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
      dateOfBirth: json['date_of_birth'] as String? ?? '',
      language: json['language'] as String? ?? 'uz',
      notificationCount: (json['notification_count'] as num?)?.toInt() ?? 0,
      isNotificationEnabled: json['is_notification_enabled'] as bool? ?? false,
      balance: json['balance'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'photo': instance.photo,
      'phone': instance.phone,
      'balance': instance.balance,
      'date_of_birth': instance.dateOfBirth,
      'language': instance.language,
      'notification_count': instance.notificationCount,
      'gender': instance.gender,
      'is_notification_enabled': instance.isNotificationEnabled,
    };
