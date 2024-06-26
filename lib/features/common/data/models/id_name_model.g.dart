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
      descriptions: (json['descriptions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maxElectricPower: (json['max_electric_power'] as num?)?.toInt() ?? -1,
      logo: json['logo'] as String? ?? '',
    );

Map<String, dynamic> _$IdNameModelToJson(IdNameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      '_type': instance.type,
      'icon': instance.icon,
      'descriptions': instance.descriptions,
      'max_electric_power': instance.maxElectricPower,
      'logo': instance.logo,
    };
