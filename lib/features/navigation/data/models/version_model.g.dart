// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) => VersionModel(
      androidRequired: json['android_required'] as bool? ?? false,
      androidVersion: json['android_version'] as String? ?? '',
      iosRequired: json['ios_required'] as bool? ?? false,
      iosVersion: json['ios_version'] as String? ?? '',
    );

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'android_version': instance.androidVersion,
      'android_required': instance.androidRequired,
      'ios_version': instance.iosVersion,
      'ios_required': instance.iosRequired,
    };
