import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';

class InProgressCharingEntity {
  final int id;
  @ConnectorConverter()
  final ConnectorEntity connector;
  final int batteryPercent;
  final String money;
  final double consumedKwh;
  final int startCommandId;
  final String vendorName;
  final String locationName;

  const InProgressCharingEntity({
    this.id = -1,
    this.connector = const ConnectorEntity(),
    this.batteryPercent = -1,
    this.money = '',
    this.consumedKwh = -1,
    this.startCommandId = -1,
    this.vendorName = '',
    this.locationName = '',
  });
}
