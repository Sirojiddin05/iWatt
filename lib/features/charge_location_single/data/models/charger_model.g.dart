// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerModel _$ChargerModelFromJson(Map<String, dynamic> json) => ChargerModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      connectors: (json['connectors'] as List<dynamic>?)
              ?.map((e) => const ConnectorConverter()
                  .fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      bookingPrice: json['booking_price'] as String? ?? '',
      chargerId: json['charger_id'] as String? ?? '',
      isConnected: json['is_connected'] as bool? ?? false,
      maxElectricPower: json['max_electric_power'] as num? ?? -1,
      name: json['name'] as String? ?? '',
      parkingPrice: json['parking_price'] as String? ?? '',
      price: json['price'] as String? ?? '',
    );

Map<String, dynamic> _$ChargerModelToJson(ChargerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'charger_id': instance.chargerId,
      'is_connected': instance.isConnected,
      'max_electric_power': instance.maxElectricPower,
      'connectors':
          instance.connectors.map(const ConnectorConverter().toJson).toList(),
      'price': instance.price,
      'parking_price': instance.parkingPrice,
      'booking_price': instance.bookingPrice,
    };
