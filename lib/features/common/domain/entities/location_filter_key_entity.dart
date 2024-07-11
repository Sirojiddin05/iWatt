//{
//     "id": 1,
//     "icon": "https://app.i-watt.uz/media/location_filter_keys/2024/07/TYPE_2_MENNEKES.svg",
//     "title": "Working",
//     "key": "is_working"
//   },

import 'package:i_watt_app/features/common/data/models/location_filter_key_model.dart';
import 'package:json_annotation/json_annotation.dart';

class LocationFilterKeyEntity {
  final int id;
  final String icon;
  final String title;
  final String key;

  const LocationFilterKeyEntity({
    this.id = -1,
    this.icon = '',
    this.title = '',
    this.key = '',
  });
}

class LocationFilterKeyConverter implements JsonConverter<LocationFilterKeyEntity, Map<String, dynamic>> {
  const LocationFilterKeyConverter();

  @override
  LocationFilterKeyEntity fromJson(Map<String, dynamic> json) => LocationFilterKeyModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(LocationFilterKeyEntity object) => {};
}
