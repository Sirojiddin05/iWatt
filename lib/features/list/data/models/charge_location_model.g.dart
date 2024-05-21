// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargeLocationModel _$ChargeLocationModelFromJson(Map<String, dynamic> json) =>
    ChargeLocationModel(
      longitude: json['longitude'] as String? ?? '',
      latitude: json['latitude'] as String? ?? '',
      chargePoints: (json['charge_points'] as List<dynamic>?)
              ?.map((e) =>
                  const StationConverter().fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      id: (json['id'] as num?)?.toInt() ?? -1,
      region: (json['region'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      landmark: json['landmark'] as String? ?? '',
      regionName: json['region_name'] as String? ?? '',
      isFavorite: json['is_favorite'] as bool? ?? false,
    );

Map<String, dynamic> _$ChargeLocationModelToJson(
        ChargeLocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'region': instance.region,
      'region_name': instance.regionName,
      'name': instance.name,
      'address': instance.address,
      'landmark': instance.landmark,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'charge_points':
          instance.chargePoints.map(const StationConverter().toJson).toList(),
      'is_favorite': instance.isFavorite,
    };
