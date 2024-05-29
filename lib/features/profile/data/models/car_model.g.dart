// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      model: (json['model'] as num?)?.toInt() ?? -1,
      typeStateNumber: (json['type_state_number'] as num?)?.toInt() ?? -1,
      chargingType: (json['charging_type'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      vehicleType: (json['vehicle_type'] as num?)?.toInt() ?? -1,
      vin: json['vin'] as String? ?? '',
      manufacturer: (json['manufacturer'] as num?)?.toInt() ?? -1,
      stateNumber: json['state_number'] as String? ?? '',
      customManufacturer: json['custom_manufacturer'] as String? ?? '',
      chargingTypeName: (json['charging_type_name'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      vehicleTypeName: json['vehicle_type_name'] as String? ?? '',
      usableBatterySize:
          (json['usable_battery_size'] as num?)?.toDouble() ?? -1,
      brand: json['brand'] as String? ?? '',
      releaseYear: json['release_year'] as String? ?? '',
      variant: json['variant'] as String? ?? '',
      modelName: json['model_name'] as String? ?? '',
      version: json['version'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      manufacturerName: json['manufacturer_name'] as String? ?? '',
      customModel: json['custom_model'] as String? ?? '',
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'type_state_number': instance.typeStateNumber,
      'charging_type': instance.chargingType,
      'vehicle_type': instance.vehicleType,
      'name': instance.name,
      'vin': instance.vin,
      'icon': instance.icon,
      'state_number': instance.stateNumber,
      'charging_type_name': instance.chargingTypeName,
      'vehicle_type_name': instance.vehicleTypeName,
      'usable_battery_size': instance.usableBatterySize,
      'brand': instance.brand,
      'release_year': instance.releaseYear,
      'variant': instance.variant,
      'model_name': instance.modelName,
      'manufacturer_name': instance.manufacturerName,
      'custom_model': instance.customModel,
      'custom_manufacturer': instance.customManufacturer,
      'version': instance.version,
    };
