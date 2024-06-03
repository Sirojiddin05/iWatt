import 'package:i_watt_app/features/charge_location_single/data/models/connector_model.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_standard.dart';
import 'package:json_annotation/json_annotation.dart';

class ConnectorEntity {
  const ConnectorEntity({
    this.id = -1,
    this.name = '',
    this.status = '',
    this.standard = const ConnectorStandardEntity(),
    this.price = -1,
    this.parkingPrice = -1,
    this.maxPower = -1,
  });

  final int id;
  final String name;
  final String status;
  @ConnectorStandardConverter()
  final ConnectorStandardEntity standard;
  final double price;
  final double parkingPrice;
  final int maxPower;

  ConnectorEntity copyWith({
    String? name,
    String? status,
    ConnectorStandardEntity? standard,
    double? price,
    double? parkingPrice,
    int? maxPower,
  }) {
    return ConnectorEntity(
      id: id,
      name: name ?? this.name,
      status: status ?? this.status,
      standard: standard ?? this.standard,
      price: price ?? this.price,
      maxPower: maxPower ?? this.maxPower,
      parkingPrice: parkingPrice ?? this.parkingPrice,
    );
  }
}

class ConnectorConverter implements JsonConverter<ConnectorEntity, Map<String, dynamic>> {
  const ConnectorConverter();

  @override
  ConnectorEntity fromJson(Map<String, dynamic> json) => ConnectorModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(ConnectorEntity object) => {};
}
