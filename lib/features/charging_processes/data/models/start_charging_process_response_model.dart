import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_charging_process_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommandResultResponseModel extends CommandResultResponseEntity {
  const CommandResultResponseModel({
    super.id,
    super.isDelivered,
  });

  factory CommandResultResponseModel.fromJson(Map<String, dynamic> json) => _$CommandResultResponseModelFromJson(json);
}
