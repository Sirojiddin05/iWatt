// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppealModel _$AppealModelFromJson(Map<String, dynamic> json) => AppealModel(
      id: (json['id'] as num?)?.toInt() ?? -1,
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$AppealModelToJson(AppealModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
