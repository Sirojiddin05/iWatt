// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClusterModel _$ClusterModelFromJson(Map<String, dynamic> json) => ClusterModel(
      avgLatitude: (json['avg_latitude'] as num?)?.toDouble() ?? -1,
      avgLongitude: (json['avg_longitude'] as num?)?.toDouble() ?? -1,
      id: (json['id'] as num?)?.toInt() ?? -1,
      quadkey: json['quadkey'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$ClusterModelToJson(ClusterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'quadkey': instance.quadkey,
      'avg_longitude': instance.avgLongitude,
      'avg_latitude': instance.avgLatitude,
    };
