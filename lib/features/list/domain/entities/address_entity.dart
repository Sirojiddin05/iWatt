import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/list/data/models/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

class AddressEntity extends Equatable {
  final int id;
  final String name;
  final String address;

  const AddressEntity({this.name = "", this.address = "", this.id = -1});

  @override
  List<Object?> get props => [name, address, id];
}

class AddressConvertor implements JsonConverter<AddressEntity, Map<String, dynamic>> {
  const AddressConvertor();
  @override
  AddressEntity fromJson(json) {
    return AddressModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AddressEntity object) => {};
}
