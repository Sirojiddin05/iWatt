// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessageModel _$ErrorMessageModelFromJson(Map<String, dynamic> json) =>
    ErrorMessageModel(
      message: json['message'] as String? ?? '',
      error: json['error'] as String? ?? '',
    );

Map<String, dynamic> _$ErrorMessageModelToJson(ErrorMessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
    };
