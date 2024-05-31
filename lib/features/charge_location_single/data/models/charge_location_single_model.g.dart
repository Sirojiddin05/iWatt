// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge_location_single_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargeLocationSingleModel _$ChargeLocationSingleModelFromJson(
        Map<String, dynamic> json) =>
    ChargeLocationSingleModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      name: json['name'] as String? ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? -1,
      address: json['address'] as String? ?? '',
      chargers: (json['chargers'] as List<dynamic>?)
              ?.map((e) =>
                  const ChargerConverter().fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isFavorite: json['is_favorite'] as bool? ?? false,
      vendor: json['vendor'] == null
          ? const VendorEntity()
          : const VendorConverter()
              .fromJson(json['vendor'] as Map<String, dynamic>),
      facilities: (json['facilities'] as List<dynamic>?)
              ?.map((e) =>
                  const IdNameConverter().fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChargeLocationSingleModelToJson(
        ChargeLocationSingleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'distance': instance.distance,
      'address': instance.address,
      'chargers':
          instance.chargers.map(const ChargerConverter().toJson).toList(),
      'is_favorite': instance.isFavorite,
      'vendor': const VendorConverter().toJson(instance.vendor),
      'facilities':
          instance.facilities.map(const IdNameConverter().toJson).toList(),
    };
