// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericPagination<T> _$GenericPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    GenericPagination<T>(
      results:
          (json['results'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String?,
    );

Map<String, dynamic> _$GenericPaginationToJson<T>(
  GenericPagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'results': instance.results.map(toJsonT).toList(),
      'count': instance.count,
      'next': instance.next,
    };
