// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_value_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeterValueMessageModel _$MeterValueMessageModelFromJson(
        Map<String, dynamic> json) =>
    MeterValueMessageModel(
      transactionId: (json['transaction_id'] as num?)?.toInt() ?? -1,
      startCommandId: (json['start_command_id'] as num?)?.toInt() ?? -1,
      batteryPercent: (json['battery_percent'] as num?)?.toInt() ?? -1,
      consumedKwh: (json['consumed_kwh'] as num?)?.toDouble() ?? -1,
      money: json['money'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$MeterValueMessageModelToJson(
        MeterValueMessageModel instance) =>
    <String, dynamic>{
      'start_command_id': instance.startCommandId,
      'transaction_id': instance.transactionId,
      'money': instance.money,
      'battery_percent': instance.batteryPercent,
      'consumed_kwh': instance.consumedKwh,
      'status': instance.status,
    };
