import 'package:i_watt_app/features/charge_location_single/domain/entities/charger_entity.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/vendor_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';

class ChargeLocationSingleEntity {
  final int id;
  final String name;
  final double distance;
  final String address;
  @ChargerConverter()
  final List<ChargerEntity> chargers;
  final bool isFavorite;
  @VendorConverter()
  final VendorEntity vendor;
  @IdNameConverter()
  final List<IdNameEntity> facilities;

  const ChargeLocationSingleEntity({
    this.id = -1,
    this.name = '',
    this.distance = -1,
    this.address = '',
    this.chargers = const [],
    this.isFavorite = false,
    this.vendor = const VendorEntity(),
    this.facilities = const [],
  });
}
