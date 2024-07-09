import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class MyClusterItem with ClusterItem {
  final int id;
  final LatLng position;

  MyClusterItem({
    required this.id,
    required this.position,
  });
  @override
  LatLng get location => position;
}
