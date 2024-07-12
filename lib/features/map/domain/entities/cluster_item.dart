import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';

class MyClusterItem with ClusterItem {
  final ChargeLocationEntity locationEntity;

  MyClusterItem({required this.locationEntity});
  @override
  LatLng get location => LatLng(double.tryParse(locationEntity.latitude) ?? 0, double.tryParse(locationEntity.longitude) ?? 0);
}
