// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_status_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorStatusMessageModel _$ConnectorStatusMessageModelFromJson(
        Map<String, dynamic> json) =>
    ConnectorStatusMessageModel(
      connectorId: (json['connector_id'] as num?)?.toInt() ?? -1,
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$ConnectorStatusMessageModelToJson(
        ConnectorStatusMessageModel instance) =>
    <String, dynamic>{
      'connector_id': instance.connectorId,
      'status': instance.status,
    };
