import 'package:i_watt_app/features/common/data/models/id_name_model.dart';
import 'package:json_annotation/json_annotation.dart';

class IdNameEntity {
  final int id;
  final String name;
  final String type;
  final String icon;

  const IdNameEntity({this.id = -1, this.name = '', this.type = '', this.icon = ''});
}

class IdNameConverter implements JsonConverter<IdNameEntity, Map<String, dynamic>> {
  const IdNameConverter();

  @override
  IdNameEntity fromJson(Map<String, dynamic> json) => IdNameModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(IdNameEntity object) => {};
}
