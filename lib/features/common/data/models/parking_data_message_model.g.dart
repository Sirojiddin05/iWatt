// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_data_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingDataMessageModel _$ParkingDataMessageModelFromJson(Map<String, dynamic> json) => ParkingDataMessageModel(
      freeParkingMinutes: (json['free_parking_minutes'] as num?)?.toInt() ?? -1,
      locationName: json['location_name'] as String? ?? '',
      parkingPrice: json['parking_price'] as String? ?? '',
      parkingStartTime: json['parking_start_time'] as String? ?? '',
      transactionId: (json['transaction_id'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$ParkingDataMessageModelToJson(ParkingDataMessageModel instance) => <String, dynamic>{
      'transaction_id': instance.transactionId,
      'location_name': instance.locationName,
      'parking_start_time': instance.parkingStartTime,
      'free_parking_minutes': instance.freeParkingMinutes,
      'parking_price': instance.parkingPrice,
    };
