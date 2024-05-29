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
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'card_number': instance.cardNumber,
      'expire_date': instance.expireDate,
      'balance': instance.balance,
      'id': instance.id,
    };
