// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionMessageModel _$TransactionMessageModelFromJson(
        Map<String, dynamic> json) =>
    TransactionMessageModel(
      transactionId: (json['transaction_id'] as num?)?.toInt() ?? -1,
      chargingDurationInMinute:
          (json['charging_duration_in_minute'] as num?)?.toInt() ?? -1,
      chargingHasStartedAt: json['charging_has_started_at'] as String? ?? '',
      consumedKwh: json['consumed_kwh'] as String? ?? '',
      locationName: json['location_name'] as String? ?? '',
      totalPrice: json['total_price'] as String? ?? '',
    );

Map<String, dynamic> _$TransactionMessageModelToJson(
        TransactionMessageModel instance) =>
    <String, dynamic>{
      'transaction_id': instance.transactionId,
      'charging_has_started_at': instance.chargingHasStartedAt,
      'location_name': instance.locationName,
      'consumed_kwh': instance.consumedKwh,
      'total_price': instance.totalPrice,
      'charging_duration_in_minute': instance.chargingDurationInMinute,
    };
