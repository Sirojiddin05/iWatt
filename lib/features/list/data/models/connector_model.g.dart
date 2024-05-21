// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectorModel _$ConnectorModelFromJson(Map<String, dynamic> json) =>
    ConnectorModel(
      chargePoint: (json['charge_point'] as num?)?.toInt() ?? -1,
      connectorId: (json['connector_id'] as num?)?.toInt() ?? -1,
      icon: json['icon'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      powerName: json['power_name'] as String? ?? '',
      price: json['price'] == null
          ? const PriceEntity()
          : const PriceConverter()
              .fromJson(json['price'] as Map<String, dynamic>),
      status: json['status'] as String? ?? '',
      typeConnection: (json['type_connection'] as num?)?.toInt() ?? -1,
      typeConnectionName: json['type_connection_name'] as String? ?? '',
      address: json['address'] == null
          ? const AddressEntity()
          : const AddressConvertor()
              .fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectorModelToJson(ConnectorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'connector_id': instance.connectorId,
      'charge_point': instance.chargePoint,
      'price': const PriceConverter().toJson(instance.price),
      'power_name': instance.powerName,
      'type_connection': instance.typeConnection,
      'type_connection_name': instance.typeConnectionName,
      'icon': instance.icon,
      'status': instance.status,
      'address': const AddressConvertor().toJson(instance.address),
    };
