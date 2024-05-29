// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericErrorModel _$GenericErrorModelFromJson(Map<String, dynamic> json) =>
    GenericErrorModel(
      statusCode: (json['status_code'] as num?)?.toInt() ?? -1,
      errors: (json['error'] as List<dynamic>?)
              ?.map(
                  (e) => ErrorMessageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GenericErrorModelToJson(GenericErrorModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'error': instance.errors,
    };
