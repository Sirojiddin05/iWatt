// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_progress_charging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InProgressChargingModel _$InProgressChargingModelFromJson(
        Map<String, dynamic> json) =>
    InProgressChargingModel(
      batteryPercent: (json['battery_percent'] as num?)?.toInt() ?? -1,
      connector: json['connector'] == null
          ? const ConnectorEntity()
          : const ConnectorConverter()
              .fromJson(json['connector'] as Map<String, dynamic>),
      consumedKwh: (json['consumed_kwh'] as num?)?.toDouble() ?? -1,
      id: (json['id'] as num?)?.toInt() ?? -1,
      locationName: json['location_name'] as String? ?? '',
      money: json['money'] as String? ?? '',
      startCommandId: (json['start_command_id'] as num?)?.toInt() ?? -1,
      vendorName: json['vendor_name'] as String? ?? '',
      freeParkingMinutes: (json['free_parking_minutes'] as num?)?.toInt() ?? -1,
      parkingPrice: json['parking_price'] as String? ?? '',
      parkingStartTime: json['parking_start_time'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$InProgressChargingModelToJson(
        InProgressChargingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'connector': const ConnectorConverter().toJson(instance.connector),
      'battery_percent': instance.batteryPercent,
      'money': instance.money,
      'consumed_kwh': instance.consumedKwh,
      'parking_start_time': instance.parkingStartTime,
      'parking_price': instance.parkingPrice,
      'free_parking_minutes': instance.freeParkingMinutes,
      'start_command_id': instance.startCommandId,
      'vendor_name': instance.vendorName,
      'location_name': instance.locationName,
      'status': instance.status,
    };
