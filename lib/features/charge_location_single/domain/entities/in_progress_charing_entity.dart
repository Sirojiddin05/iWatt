import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';

class InProgressChargingEntity {
  final int id;
  @ConnectorConverter()
  final ConnectorEntity connector;
  final int batteryPercent;
  final String money;
  final double consumedKwh;
  final String parkingStartTime;
  final String parkingPrice;
  final int freeParkingMinutes;
  final int startCommandId;
  final String vendorName;
  final String locationName;
  final String status;

  const InProgressChargingEntity({
    this.id = -1,
    this.connector = const ConnectorEntity(),
    this.batteryPercent = -1,
    this.money = '',
    this.consumedKwh = -1,
    this.startCommandId = -1,
    this.vendorName = '',
    this.locationName = '',
    this.parkingPrice = '',
    this.parkingStartTime = '',
    this.status = '',
    this.freeParkingMinutes = -1,
  });
}
