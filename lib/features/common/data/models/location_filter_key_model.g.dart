// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_filter_key_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationFilterKeyModel _$LocationFilterKeyModelFromJson(
        Map<String, dynamic> json) =>
    LocationFilterKeyModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      icon: json['icon'] as String? ?? '',
      title: json['title'] as String? ?? '',
      key: json['key'] as String? ?? '',
    );

Map<String, dynamic> _$LocationFilterKeyModelToJson(
        LocationFilterKeyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'title': instance.title,
      'key': instance.key,
    };
