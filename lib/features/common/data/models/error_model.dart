import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorModel {
  final String message;
  final int code;

  const ErrorModel({
    this.message = '',
    this.code = -1,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);
}
