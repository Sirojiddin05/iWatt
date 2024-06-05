// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_features_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionFeaturesModel _$VersionFeaturesModelFromJson(
        Map<String, dynamic> json) =>
    VersionFeaturesModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      version: json['version'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      file: json['file'] as String? ?? '',
    );

Map<String, dynamic> _$VersionFeaturesModelToJson(
        VersionFeaturesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'title': instance.title,
      'description': instance.description,
      'file': instance.file,
    };
