// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_result_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommandResultMessageModel _$CommandResultMessageModelFromJson(
        Map<String, dynamic> json) =>
    CommandResultMessageModel(
      commandId: (json['command_id'] as num?)?.toInt() ?? -1,
      status: json['status'] as bool? ?? false,
    );

Map<String, dynamic> _$CommandResultMessageModelToJson(
        CommandResultMessageModel instance) =>
    <String, dynamic>{
      'command_id': instance.commandId,
      'status': instance.status,
    };
