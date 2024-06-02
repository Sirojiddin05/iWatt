// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistoryModel _$SearchHistoryModelFromJson(Map<String, dynamic> json) =>
    SearchHistoryModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      location: (json['location'] as num?)?.toInt() ?? -1,
      locationId: (json['location_id'] as num?)?.toInt() ?? -1,
      locationName: json['location_name'] as String? ?? '',
      vendorName: json['vendor_name'] as String? ?? '',
      address: json['address'] as String? ?? '',
    );

Map<String, dynamic> _$SearchHistoryModelToJson(SearchHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'location_id': instance.locationId,
      'location_name': instance.locationName,
      'vendor_name': instance.vendorName,
      'address': instance.address,
    };
