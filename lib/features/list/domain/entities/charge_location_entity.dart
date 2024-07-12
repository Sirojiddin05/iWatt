import 'package:i_watt_app/features/list/data/models/charge_location_model.dart';
import 'package:json_annotation/json_annotation.dart';

class ChargeLocationEntity {
  final int id;
  final String latitude;
  final String longitude;
  final String address;
  final int connectorsCount;
  final List<String> connectorsStatus;
  final String vendorName;
  final String locationName;
  final double distance;
  final bool isFavorite;
  final List<num> maxElectricPowers;
  final String logo;
  final int chargersCount;
  final String locationAppearance;

  const ChargeLocationEntity({
    this.id = -1,
    this.address = '',
    this.longitude = '',
    this.latitude = '',
    this.connectorsCount = 0,
    this.connectorsStatus = const [],
    this.distance = -1,
    this.vendorName = '',
    this.locationName = '',
    this.isFavorite = false,
    this.maxElectricPowers = const [],
    this.logo = '',
    this.chargersCount = -1,
    this.locationAppearance = '',
  });

  ChargeLocationEntity copyWith({
    int? id,
    String? latitude,
    String? longitude,
    String? address,
    int? connectorsCount,
    List<String>? connectorsStatus,
    double? distance,
    String? vendorName,
    String? locationName,
    bool? isFavorite,
    List<num>? maxElectricPowers,
    String? logo,
    int? chargersCount,
    String? locationAppearance,
  }) {
    return ChargeLocationEntity(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      connectorsCount: connectorsCount ?? this.connectorsCount,
      connectorsStatus: connectorsStatus ?? this.connectorsStatus,
      distance: distance ?? this.distance,
      vendorName: vendorName ?? this.vendorName,
      locationName: locationName ?? this.locationName,
      isFavorite: isFavorite ?? this.isFavorite,
      maxElectricPowers: maxElectricPowers ?? this.maxElectricPowers,
      logo: logo ?? this.logo,
      chargersCount: chargersCount ?? this.chargersCount,
      locationAppearance: locationAppearance ?? this.locationAppearance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'connectors_count': connectorsCount,
      'vendor_name': longitude,
      'location_name': locationName,
      'logo': logo,
      'connectors_status': connectorsStatus.join(','),
      'distance': distance,
      'is_favorite': isFavorite ? 1 : 0,
      'max_electric_powers': maxElectricPowers.join(','),
      'location_appearance': locationAppearance,
    };
  }
}

class ChargeLocationConverter<S> implements JsonConverter<ChargeLocationEntity, Map<String, dynamic>?> {
  const ChargeLocationConverter();

  @override
  ChargeLocationModel fromJson(Map<String, dynamic>? json) => ChargeLocationModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(ChargeLocationEntity object) => ChargeLocationModel(
        id: object.id,
        latitude: object.latitude,
        longitude: object.longitude,
        address: object.address,
        connectorsCount: object.connectorsCount,
        connectorsStatus: object.connectorsStatus,
        distance: object.distance,
        vendorName: object.vendorName,
        locationName: object.locationName,
        isFavorite: object.isFavorite,
      ).toJson();
}
