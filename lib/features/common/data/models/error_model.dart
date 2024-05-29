import 'package:i_watt_app/features/common/data/models/error_message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericErrorModel {
  @JsonKey(name: 'status_code', defaultValue: -1)
  final int statusCode;
  @JsonKey(name: 'errors', defaultValue: [])
  final List<ErrorMessageModel> errors;

  const GenericErrorModel({this.statusCode = -1, this.errors = const []});

  factory GenericErrorModel.fromJson(Map<String, dynamic> json) => _$GenericErrorModelFromJson(json);

  String get message => errors.map((e) => e.message).join('\n');
  String get error => errors.map((e) => e.error).join('\n');
}
