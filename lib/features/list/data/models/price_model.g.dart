// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      priceConnector: json['price_connector'] as String? ?? '',
      priceParking: json['price_parking'] as String? ?? '',
      priceParkingType: json['price_parking_type'] as String? ?? '',
      priceType: json['price_type'] as String? ?? '',
      priceWaiting: json['price_waiting'] as String? ?? '',
      priceWaitingType: json['price_waiting_type'] as String? ?? '',
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price_connector': instance.priceConnector,
      'price_type': instance.priceType,
      'price_parking': instance.priceParking,
      'price_parking_type': instance.priceParkingType,
      'price_waiting': instance.priceWaiting,
      'price_waiting_type': instance.priceWaitingType,
    };
