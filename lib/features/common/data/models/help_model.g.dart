// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpModel _$HelpModelFromJson(Map<String, dynamic> json) => HelpModel(
      helpEmail: json['help_email'] as String? ?? '',
      helpPhoneNumber: json['help_phone_number'] as String? ?? '',
      helpTelegramLink: json['help_telegram_link'] as String? ?? '',
    );

Map<String, dynamic> _$HelpModelToJson(HelpModel instance) => <String, dynamic>{
      'help_telegram_link': instance.helpTelegramLink,
      'help_email': instance.helpEmail,
      'help_phone_number': instance.helpPhoneNumber,
    };
