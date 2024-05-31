// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_standart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorStandardModel _$ConnectorStandardModelFromJson(
        Map<String, dynamic> json) =>
    ConnectorStandardModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      maxVoltage: (json['max_voltage'] as num?)?.toInt() ?? -1,
      type: json['_type'] as String? ?? '',
    );

Map<String, dynamic> _$ConnectorStandardModelToJson(
        ConnectorStandardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'max_voltage': instance.maxVoltage,
      '_type': instance.type,
    };
