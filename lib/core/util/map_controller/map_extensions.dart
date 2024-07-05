import 'package:yandex_maps_mapkit/mapkit.dart' as map_kit;

extension CameraPositionExtension on map_kit.CameraPosition {
  map_kit.CameraPosition copyWith({map_kit.Point? target, double? zoom, double? azimuth, double? tilt}) {
    return map_kit.CameraPosition(
      target ?? this.target,
      zoom: zoom ?? this.zoom,
      azimuth: azimuth ?? this.azimuth,
      tilt: tilt ?? this.tilt,
    );
  }
}
