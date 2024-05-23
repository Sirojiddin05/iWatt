import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:i_watt_app/features/list/domain/entities/station_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class ChargeLocationEntity extends Equatable {
  final int id;
  final int region;
  final String regionName;
  final String name;
  final String address;
  final String landmark;
  final String longitude;
  final String latitude;
  @StationConverter()
  final List<StationEntity> chargePoints;
  final bool isFavorite;
  final double distance;

  const ChargeLocationEntity({
    this.id = -1,
    this.region = -1,
    this.regionName = '',
    this.name = '',
    this.address = '',
    this.landmark = '',
    this.longitude = '',
    this.latitude = '',
    this.chargePoints = const [],
    this.isFavorite = false,
    this.distance = -1,
  });

  ChargeLocationEntity copyWith({
    bool? isFavorite,
    int? id,
  }) {
    return ChargeLocationEntity(
      id: id ?? this.id,
      name: name,
      address: address,
      chargePoints: chargePoints,
      isFavorite: isFavorite ?? this.isFavorite,
      landmark: landmark,
      latitude: latitude,
      longitude: longitude,
      region: region,
      regionName: regionName,
      distance: distance,
    );
  }

  @override
  List<Object?> get props => [
        id,
        region,
        regionName,
        name,
        address,
        landmark,
        longitude,
        latitude,
        chargePoints,
        isFavorite,
        distance,
      ];
}

class ChargeLocationConverter<S> implements JsonConverter<ChargeLocationEntity, Map<String, dynamic>?> {
  const ChargeLocationConverter();

  @override
  ChargeLocationModel fromJson(Map<String, dynamic>? json) => ChargeLocationModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(ChargeLocationEntity object) => ChargeLocationModel(
        id: object.id,
        chargePoints: object.chargePoints,
        name: object.name,
        latitude: object.latitude,
        longitude: object.longitude,
        landmark: object.landmark,
        region: object.region,
        address: object.address,
        isFavorite: object.isFavorite,
        regionName: object.regionName,
      ).toJson();
}
