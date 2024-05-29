import 'package:i_watt_app/features/profile/domain/entities/payment_status_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_status_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentStatusModel extends PaymentStatusEntity {
  const PaymentStatusModel({
    super.ztyResponse,
    super.status,
    super.paidAt,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) => _$PaymentStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentStatusModelToJson(this);
}
