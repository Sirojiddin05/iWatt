import 'package:i_watt_app/core/util/map_controller/map_extensions.dart';
import 'package:i_watt_app/core/util/map_controller/map_typedefs.dart';
import 'package:yandex_maps_mapkit/image.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as map_kit;

final class CustomMapController {
  CustomMapController({
    required this.mapWindow,
    required this.onCameraChanged,
  }) : _cameraListener = MapCameraListenerImpl(onCameraChanged) {
    addCameraListener();
  }
  final map_kit.MapWindow mapWindow;
  final OnCameraPositionChanged onCameraChanged;
  final map_kit.MapCameraListener _cameraListener;

  map_kit.CameraPosition get cameraPosition => mapWindow.map.cameraPosition;
  map_kit.MapObjectCollection get mapObjects => mapWindow.map.mapObjects;

  void addCameraListener() => mapWindow.map.addCameraListener(_cameraListener);
  void zoomOut() {
    final zoom = cameraPosition.zoom - 1;
    final position = cameraPosition.copyWith(zoom: zoom);
    animateToPosition(position);
  }

  void zoomIn() {
    final zoom = cameraPosition.zoom + 1;
    final position = cameraPosition.copyWith(zoom: zoom);
    animateToPosition(position);
  }

  void animateToPosition(map_kit.CameraPosition position) {
    mapWindow.map.moveWithAnimation(
      position,
      const map_kit.Animation(map_kit.AnimationType.Linear, duration: 400),
    );
  }

  void setMapStyle(String style) {
    mapWindow.map.setMapStyle(style);
  }

  void setNightMode(bool nightModeEnabled) {
    mapWindow.map.nightModeEnabled = nightModeEnabled;
  }

  void set2DMode(bool enable) {
    mapWindow.map.set2DMode(enable);
  }

  map_kit.PlacemarkMapObject addPlaceMark({
    required map_kit.Point point,
    required map_kit.IconStyle style,
    required ImageProvider image,
    required OnMapObjectTap onObjectTap,
  }) {
    return mapWindow.map.mapObjects.addPlacemarkWithImageStyle(point, image, style)
      ..geometry = point
      ..opacity = 1
      ..addTapListener(
        MapObjectTapListenerImpl(onObjectTap),
      );
  }
}

final class MapCameraListenerImpl implements map_kit.MapCameraListener {
  const MapCameraListenerImpl(this.onCameraChanged);
  final OnCameraPositionChanged onCameraChanged;
  @override
  void onCameraPositionChanged(
    map_kit.Map map,
    map_kit.CameraPosition cameraPosition,
    map_kit.CameraUpdateReason cameraUpdateReason,
    bool finished,
  ) {
    onCameraChanged(map, cameraPosition, cameraUpdateReason, finished);
  }
}

final class MapObjectTapListenerImpl implements map_kit.MapObjectTapListener {
  const MapObjectTapListenerImpl(this.onObjectTap);

  final OnMapObjectTap onObjectTap;

  @override
  bool onMapObjectTap(map_kit.MapObject mapObject, map_kit.Point point) {
    onObjectTap(mapObject, point);
    return true;
  }
}
