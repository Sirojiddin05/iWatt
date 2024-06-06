import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meter_value_message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MeterValueMessageModel extends MeterValueMessageEntity {
  const MeterValueMessageModel({
    super.transactionId,
    super.startCommandId,
    super.batteryPercent,
    super.consumedKwh,
    super.money,
    super.status,
    super.currentKwh,
    super.estimatedTime,
  });

  factory MeterValueMessageModel.fromJson(Map<String, dynamic> json) => _$MeterValueMessageModelFromJson(json);
}
