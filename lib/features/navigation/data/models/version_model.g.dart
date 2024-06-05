// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) => VersionModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      number: json['number'] as String? ?? '',
      platformType: json['platform_type'] as String? ?? '',
      isForceUpdate: json['is_force_update'] as bool? ?? false,
    );

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'platform_type': instance.platformType,
      'is_force_update': instance.isForceUpdate,
    };
