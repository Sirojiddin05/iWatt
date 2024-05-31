// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorModel _$ConnectorModelFromJson(Map<String, dynamic> json) =>
    ConnectorModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      standard: json['standard'] == null
          ? const ConnectorStandardEntity()
          : const ConnectorStandardConverter()
              .fromJson(json['standard'] as Map<String, dynamic>),
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$ConnectorModelToJson(ConnectorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'standard': const ConnectorStandardConverter().toJson(instance.standard),
    };
