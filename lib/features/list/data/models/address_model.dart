import 'package:i_watt_app/features/list/domain/entities/address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressModel extends AddressEntity {
  const AddressModel({super.name, super.address, super.id});

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
}
