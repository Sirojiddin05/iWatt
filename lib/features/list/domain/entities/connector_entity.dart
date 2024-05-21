import 'package:i_watt_app/features/list/data/models/connector_model.dart';
import 'package:i_watt_app/features/list/domain/entities/address_entity.dart';
import 'package:i_watt_app/features/list/domain/entities/price_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class ConnectorEntity {
  final int id;
  final String name;
  final int connectorId;
  final int chargePoint;
  @PriceConverter()
  final PriceEntity price;
  final String powerName;
  final int typeConnection;
  final String typeConnectionName;
  final String icon;
  final String status;
  @AddressConvertor()
  final AddressEntity address;

  const ConnectorEntity(
      {this.id = -1,
      this.name = '',
      this.connectorId = -1,
      this.chargePoint = -1,
      this.price = const PriceEntity(),
      this.powerName = '',
      this.typeConnection = -1,
      this.typeConnectionName = '',
      this.address = const AddressEntity(),
      this.icon = '',
      this.status = ''});

  ConnectorEntity copyWith({String? status}) {
    return ConnectorEntity(
      id: id,
      name: name,
      connectorId: connectorId,
      chargePoint: chargePoint,
      price: price,
      powerName: powerName,
      typeConnection: typeConnection,
      typeConnectionName: typeConnectionName,
      icon: icon,
      address: address,
      status: status ?? this.status,
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
