import 'package:i_watt_app/features/common/domain/entities/parking_data_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_data_message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ParkingDataMessageModel extends ParkingDataMessageEntity {
  const ParkingDataMessageModel({
    super.freeParkingMinutes,
    super.locationName,
    super.parkingEndTime,
    super.parkingPrice,
    super.parkingStartTime,
    super.transactionId,
  });
  factory ParkingDataMessageModel.fromJson(Map<String, dynamic> json) => _$ParkingDataMessageModelFromJson(json);
}
