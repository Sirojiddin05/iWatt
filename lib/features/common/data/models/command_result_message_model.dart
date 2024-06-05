import 'package:i_watt_app/features/common/domain/entities/command_result_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'command_result_message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommandResultMessageModel extends CommandResultMessageEntity {
  const CommandResultMessageModel({
    super.commandId,
    super.status,
    super.commandType,
  });

  factory CommandResultMessageModel.fromJson(Map<String, dynamic> json) => _$CommandResultMessageModelFromJson(json);
}
