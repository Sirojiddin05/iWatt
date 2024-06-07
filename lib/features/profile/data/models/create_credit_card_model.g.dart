// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCreditCardModel _$CreateCreditCardModelFromJson(
        Map<String, dynamic> json) =>
    CreateCreditCardModel(
      phoneNumber: json['phone_number'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$CreateCreditCardModelToJson(
        CreateCreditCardModel instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'token': instance.token,
    };
