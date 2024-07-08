// import 'package:i_watt_app/core/util/map_controller/map_camera_listener.dart';
// import 'package:i_watt_app/core/util/map_controller/map_extensions.dart';
// import 'package:i_watt_app/core/util/map_controller/map_input_listener.dart';
// import 'package:i_watt_app/core/util/map_controller/map_object_tap_listener.dart';
// import 'package:i_watt_app/core/util/map_controller/map_typedefs.dart';
// import 'package:yandex_maps_mapkit/image.dart';
// import 'package:yandex_maps_mapkit/mapkit.dart' as map_kit;
//
// final class CustomMapController {
//   CustomMapController({
//     required this.mapWindow,
//     required this.onCameraChanged,
//   }) : _cameraListener = MapCameraListenerImpl(onCameraChanged) {
//     addCameraListener();
//     mapWindow.map.addInputListener(const MapInputListenerImpl());
//   }
//   final map_kit.MapWindow mapWindow;
//   final OnCameraPositionChanged onCameraChanged;
//   final map_kit.MapCameraListener _cameraListener;
//
//   map_kit.CameraPosition get cameraPosition => mapWindow.map.cameraPosition;
//   map_kit.MapObjectCollection get mapObjects => mapWindow.map.mapObjects;
//
//   void addCameraListener() => mapWindow.map.addCameraListener(_cameraListener);
//   void zoomOut() {
//     final zoom = cameraPosition.zoom - 1;
//     final position = cameraPosition.copyWith(zoom: zoom);
//     animateToPosition(position);
//   }
//
//   void zoomIn() {
//     final zoom = cameraPosition.zoom + 1;
//     final position = cameraPosition.copyWith(zoom: zoom);
//
//     animateToPosition(position);
//   }
//
//   void animateToPosition(map_kit.CameraPosition position) {
//     mapWindow.map.moveWithAnimation(
//       position,
//       const map_kit.Animation(map_kit.AnimationType.Smooth, duration: 0.2),
//     );
//   }
//
//   void setMapStyle(String style) {
//     mapWindow.map.setMapStyle(style);
//   }
//
//   void setNightMode(bool nightModeEnabled) {
//     mapWindow.map.nightModeEnabled = nightModeEnabled;
//   }
//
//   void set2DMode(bool enable) {
//     mapWindow.map.set2DMode(enable);
//   }
//
//   List<map_kit.PlacemarkMapObject> addPlaceMarks(
//       {required List<map_kit.Point> points,
//       required List<map_kit.IconStyle> styles,
//       required List<ImageProvider> images,
//       required List<MapObjectTapListenerImpl> onObjectTap,
//       required}) {
//     final List<map_kit.PlacemarkMapObject> placemarks = [];
//     mapObjects.clear();
//     mapWindow.map.wipe();
//
//     for (var i = 0; i < points.length; i++) {
//       placemarks.add(
//         mapWindow.map.mapObjects.addPlacemarkWithImageStyle(points[i], images[i], styles[i])
//           ..geometry = points[i]
//           ..opacity = 1
//           ..addTapListener(onObjectTap[i]),
//       );
//     }
//     return placemarks;
//     // return mapWindow.map.mapObjects.addPlacemarkWithImageStyle(point, image, style)
//     //   ..geometry = point
//     //   ..opacity = 1
//     //   ..addTapListener(MapObjectTapListenerImpl(onObjectTap));
//   }
//
//   map_kit.ClusterizedPlacemarkCollection addCluster(map_kit.ClusterListener clusters) {
//     return mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(clusters);
//   }
// }
