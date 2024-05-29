import 'package:json_annotation/json_annotation.dart';

part 'error_message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ErrorMessageModel {
  final String message;
  final String error;

  const ErrorMessageModel({
    this.message = '',
    this.error = '',
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) => _$ErrorMessageModelFromJson(json);
}
