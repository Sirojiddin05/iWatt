import 'package:yandex_maps_mapkit/mapkit.dart' as map_kit;

typedef OnCameraPositionChanged = void Function(
  map_kit.Map map,
  map_kit.CameraPosition cameraPosition,
  map_kit.CameraUpdateReason cameraUpdateReason,
  bool finished,
);

typedef OnMapObjectTap = void Function(map_kit.MapObject mapObject, map_kit.Point point);
