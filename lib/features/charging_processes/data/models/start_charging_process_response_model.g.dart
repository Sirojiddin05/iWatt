// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_charging_process_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommandResultResponseModel _$CommandResultResponseModelFromJson(
        Map<String, dynamic> json) =>
    CommandResultResponseModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      isDelivered: json['is_delivered'] as bool? ?? false,
    );

Map<String, dynamic> _$CommandResultResponseModelToJson(
        CommandResultResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_delivered': instance.isDelivered,
    };
