// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) => StationModel(
      bootTimestamp: json['boot_timestamp'] as String? ?? '',
      connected: json['connected'] as bool? ?? false,
      connectors: (json['connectors'] as List<dynamic>?)
              ?.map((e) => const ConnectorConverter()
                  .fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      firmware: json['firmware'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? -1,
      identity: json['identity'] as String? ?? '',
      lastHeartbeat: json['last_heartbeat'] as String? ?? '',
      model: json['model'] as String? ?? '',
      name: json['name'] as String? ?? '',
      serialNumber: json['serial_number'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      type: json['type'] as String? ?? '',
      vendor: json['vendor'] as String? ?? '',
      isReservationEnabled: json['is_reservation_enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'vendor': instance.vendor,
      'serial_number': instance.serialNumber,
      'firmware': instance.firmware,
      'type': instance.type,
      'last_heartbeat': instance.lastHeartbeat,
      'boot_timestamp': instance.bootTimestamp,
      'identity': instance.identity,
      'connected': instance.connected,
      'status': instance.status,
      'connectors':
          instance.connectors.map(const ConnectorConverter().toJson).toList(),
      'is_reservation_enabled': instance.isReservationEnabled,
    };
