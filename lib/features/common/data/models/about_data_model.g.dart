// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsModel _$AboutUsModelFromJson(Map<String, dynamic> json) => AboutUsModel(
      description: json['description'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      botUsername: json['bot_username'] as String? ?? "",
      email: json['email'] as String? ?? "",
      title: json['title'] as String? ?? "",
    );

Map<String, dynamic> _$AboutUsModelToJson(AboutUsModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'phone': instance.phone,
      'email': instance.email,
      'bot_username': instance.botUsername,
    };
