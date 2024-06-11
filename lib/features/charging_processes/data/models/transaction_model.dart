import 'package:i_watt_app/features/charging_processes/domain/entities/transaction_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TransactionModel extends TransactionEntity {
  const TransactionModel({
    super.id,
    super.createdAt,
    super.locationName,
    super.totalPrice,
    super.vendorName,
  });
  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
}
