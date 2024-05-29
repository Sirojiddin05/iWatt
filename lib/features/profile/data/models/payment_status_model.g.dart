// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentStatusModel _$PaymentStatusModelFromJson(Map<String, dynamic> json) =>
    PaymentStatusModel(
      ztyResponse: json['zty_response'] as String? ?? '',
      status: json['status'] as String? ?? '',
      paidAt: json['paid_at'] as String? ?? '',
    );

Map<String, dynamic> _$PaymentStatusModelToJson(PaymentStatusModel instance) =>
    <String, dynamic>{
      'zty_response': instance.ztyResponse,
      'status': instance.status,
      'paid_at': instance.paidAt,
    };
