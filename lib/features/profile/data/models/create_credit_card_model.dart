import 'package:i_watt_app/features/profile/domain/entities/create_credit_card_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'create_credit_card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateCreditCardModel extends CreateCreditCardEntity {
  const CreateCreditCardModel({
    required super.phoneNumber,
    required super.token,
  });

  factory CreateCreditCardModel.fromJson(Map<String, dynamic> json) => _$CreateCreditCardModelFromJson(json);
}
