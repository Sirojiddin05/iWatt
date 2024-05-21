import 'package:json_annotation/json_annotation.dart';

part 'generic_pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericPagination<T> {
  @JsonKey(name: 'results', defaultValue: [])
  final List<T> results;
  @JsonKey(name: 'count', defaultValue: 0)
  final int count;
  @JsonKey(name: 'next')
  final String? next;

  GenericPagination({required this.results, required this.count, required this.next});
  factory GenericPagination.fromJson(Map<String, dynamic> json, T Function(Object?) fetch) => _$GenericPaginationFromJson(json, fetch);
}
