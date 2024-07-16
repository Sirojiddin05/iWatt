// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargeLocationModel _$ChargeLocationModelFromJson(Map<String, dynamic> json) =>
    ChargeLocationModel(
      longitude: json['longitude'] as String? ?? '',
      latitude: json['latitude'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? -1,
      address: json['address'] as String? ?? '',
      connectorsCount: (json['connectors_count'] as num?)?.toInt() ?? 0,
      connectorsStatus: (json['connectors_status'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      distance: (json['distance'] as num?)?.toDouble() ?? -1,
      vendorName: json['vendor_name'] as String? ?? '',
      locationName: json['location_name'] as String? ?? '',
      isFavorite: json['is_favorite'] as bool? ?? false,
      chargersCount: (json['chargers_count'] as num?)?.toInt() ?? -1,
      logo: json['logo'] as String? ?? '',
      maxElectricPowers: (json['max_electric_powers'] as List<dynamic>?)
              ?.map((e) => e as num)
              .toList() ??
          const [],
      locationAppearance: json['location_appearance'] as String? ?? '',
      status: (json['status'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      vendor: _$JsonConverterFromJson<Map<String, dynamic>, VendorEntity>(
          json['vendor'], const VendorConverter().fromJson),
    );

Map<String, dynamic> _$ChargeLocationModelToJson(
        ChargeLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'connectors_count': instance.connectorsCount,
      'connectors_status': instance.connectorsStatus,
      'vendor_name': instance.vendorName,
      'location_name': instance.locationName,
      'distance': instance.distance,
      'is_favorite': instance.isFavorite,
      'max_electric_powers': instance.maxElectricPowers,
      'logo': instance.logo,
      'chargers_count': instance.chargersCount,
      'location_appearance': instance.locationAppearance,
      'status': instance.status,
      'vendor': _$JsonConverterToJson<Map<String, dynamic>, VendorEntity>(
          instance.vendor, const VendorConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
