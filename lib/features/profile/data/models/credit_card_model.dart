import 'package:i_watt_app/features/profile/domain/entities/credit_card_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreditCardModel extends CreditCardEntity {
  const CreditCardModel({
    super.balance,
    super.cardNumber,
    super.id,
    super.expireDate,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) => _$CreditCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);
}
