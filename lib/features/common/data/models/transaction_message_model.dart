import 'package:i_watt_app/features/common/domain/entities/transaction_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TransactionMessageModel extends TransactionMessageEntity {
  const TransactionMessageModel({
    super.transactionId,
    super.chargingDurationInMinute,
    super.chargingHasStartedAt,
    super.consumedKwh,
    super.locationName,
    super.totalPrice,
    super.chargingHasEndedAt,
    super.chargingPrice,
    super.parkingEndTime,
    super.parkingPrice,
    super.parkingStartTime,
    super.vendorName,
  });
  factory TransactionMessageModel.fromJson(Map<String, dynamic> json) => _$TransactionMessageModelFromJson(json);
}
