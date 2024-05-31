import 'package:i_watt_app/features/charge_location_single/data/models/charger_model.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class ChargerEntity {
  final int id;
  final String name;
  final String chargerId;
  final bool isConnected;
  final num maxElectricPower;
  @ConnectorConverter()
  final List<ConnectorEntity> connectors;
  final String price;
  final String parkingPrice;
  final String bookingPrice;

  const ChargerEntity({
    this.id = -1,
    this.name = '',
    this.chargerId = '',
    this.isConnected = false,
    this.maxElectricPower = -1,
    this.connectors = const [],
    this.price = '',
    this.parkingPrice = '',
    this.bookingPrice = '',
  });
}

class ChargerConverter implements JsonConverter<ChargerEntity, Map<String, dynamic>> {
  const ChargerConverter();

  @override
  ChargerEntity fromJson(Map<String, dynamic> json) => ChargerModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(ChargerEntity object) => {};
}
