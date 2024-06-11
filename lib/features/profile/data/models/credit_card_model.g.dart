// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardModel _$CreditCardModelFromJson(Map<String, dynamic> json) =>
    CreditCardModel(
      balance: (json['balance'] as num?)?.toInt() ?? -1,
      cardNumber: json['card_number'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? -1,
      expireDate: json['expire_date'] as String? ?? '',
      bankName: json['bank_name'] as String? ?? '',
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'card_number': instance.cardNumber,
      'expire_date': instance.expireDate,
      'balance': instance.balance,
      'bank_name': instance.bankName,
    };
