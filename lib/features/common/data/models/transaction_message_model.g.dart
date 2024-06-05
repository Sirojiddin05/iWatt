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
      chargingHasEndedAt: json['charging_has_ended_at'] as String? ?? '',
      chargingPrice: json['charging_price'] as String? ?? '',
      parkingEndTime: json['parking_end_time'] as String? ?? '',
      parkingPrice: json['parking_price'] as String? ?? '',
      parkingStartTime: json['parking_start_time'] as String? ?? '',
      vendorName: json['vendor_name'] as String? ?? '',
    );

Map<String, dynamic> _$TransactionMessageModelToJson(
        TransactionMessageModel instance) =>
    <String, dynamic>{
      'transaction_id': instance.transactionId,
      'charging_has_started_at': instance.chargingHasStartedAt,
      'charging_has_ended_at': instance.chargingHasEndedAt,
      'location_name': instance.locationName,
      'vendor_name': instance.vendorName,
      'parking_start_time': instance.parkingStartTime,
      'parking_end_time': instance.parkingEndTime,
      'consumed_kwh': instance.consumedKwh,
      'charging_price': instance.chargingPrice,
      'parking_price': instance.parkingPrice,
      'total_price': instance.totalPrice,
      'charging_duration_in_minute': instance.chargingDurationInMinute,
    };
