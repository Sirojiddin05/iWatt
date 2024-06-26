import 'package:i_watt_app/features/common/data/models/id_name_model.dart';
import 'package:json_annotation/json_annotation.dart';

class IdNameEntity {
  final int id;
  final String name;
  @JsonKey(name: '_type', defaultValue: '')
  final String type;
  final String icon;
  final List<String> descriptions;
  @JsonKey(name: 'max_electric_power', defaultValue: -1)
  final int maxElectricPower;
  final String logo;

  const IdNameEntity({
    this.id = -1,
    this.name = '',
    this.icon = '',
    this.type = '',
    this.descriptions = const [],
    this.maxElectricPower = -1,
    this.logo = '',
  });
}

class IdNameConverter implements JsonConverter<IdNameEntity, Map<String, dynamic>> {
  const IdNameConverter();

  @override
  IdNameEntity fromJson(Map<String, dynamic> json) => IdNameModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(IdNameEntity object) => {};
}
