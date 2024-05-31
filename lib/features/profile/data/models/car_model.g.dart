// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      model: json['model'] as String? ?? '',
      stateNumberType: (json['state_number_type'] as num?)?.toInt() ?? -1,
      vin: json['vin'] as String? ?? '',
      manufacturer: json['manufacturer'] as String? ?? '',
      stateNumber: json['state_number'] as String? ?? '',
      connectorType: (json['connector_type'] as List<dynamic>?)
              ?.map((e) =>
                  const IdNameConverter().fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'state_number_type': instance.stateNumberType,
      'state_number': instance.stateNumber,
      'connector_type':
          instance.connectorType.map(const IdNameConverter().toJson).toList(),
      'vin': instance.vin,
    };
