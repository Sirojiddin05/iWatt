// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      createdAt: json['created_at'] as String? ?? '',
      locationName: json['location_name'] as String? ?? '',
      totalPrice: json['total_price'] as String? ?? '',
      vendorName: json['vendor_name'] as String? ?? '',
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location_name': instance.locationName,
      'vendor_name': instance.vendorName,
      'created_at': instance.createdAt,
      'total_price': instance.totalPrice,
    };
