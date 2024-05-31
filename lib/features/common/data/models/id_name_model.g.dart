// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdNameModel _$IdNameModelFromJson(Map<String, dynamic> json) => IdNameModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      type: json['_type'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      description: (json['description'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$IdNameModelToJson(IdNameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      '_type': instance.type,
      'icon': instance.icon,
      'description': instance.description,
    };
