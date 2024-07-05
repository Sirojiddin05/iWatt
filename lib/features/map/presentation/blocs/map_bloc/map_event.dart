part of 'map_bloc.dart';

abstract class MapEvent {
  const MapEvent();
}

class SetClusters extends MapEvent {
  final double zoom;
  final Point point;
  const SetClusters({required this.zoom, required this.point});
}

class SetFilteredLocations extends MapEvent {
  const SetFilteredLocations(this.locations);
  final List<ChargeLocationEntity> locations;
}

class RequestLocationAccess extends MapEvent {
  const RequestLocationAccess();
}

class GetCurrentLocation extends MapEvent {}

class ClearFilter extends MapEvent {
  const ClearFilter();
}

class SetLocationAccessStateEvent extends MapEvent {
  final LocationPermissionStatus status;

  const SetLocationAccessStateEvent({required this.status});
}

class SetMyPositionEvent extends MapEvent {
  const SetMyPositionEvent({this.forceSet = false});
  final bool forceSet;
}

class InitializeMapControllerEvent extends MapEvent {
  const InitializeMapControllerEvent({required this.mapController, required this.context});

  final YandexMapController mapController;
  final BuildContext context;
}

class ChangeZoomEvent extends MapEvent {
  const ChangeZoomEvent(this.cameraUpdate);

  final CameraUpdate cameraUpdate;
}

class SaveZoomOnCameraPositionChanged extends MapEvent {
  const SaveZoomOnCameraPositionChanged(this.zoom);

  final double zoom;
}

class DrawChargeLocationsEvent extends MapEvent {
  const DrawChargeLocationsEvent({required this.onLocationTap, this.withLuminosity = false});

  final ValueChanged<ClusterEntity> onLocationTap;
  final bool withLuminosity;
}

class SelectChargeLocationEvent extends MapEvent {
  const SelectChargeLocationEvent({required this.location});

  final ChargeLocationEntity location;
}

class CheckIfSettingsTriggered extends MapEvent {}

class ChangeLuminosityStateEvent extends MapEvent {
  const ChangeLuminosityStateEvent({required this.hasLuminosity});

  final bool hasLuminosity;
}

class SetDraggableSheetOffsetEvent extends MapEvent {
  const SetDraggableSheetOffsetEvent(this.offset);

  final double offset;
}

class SetCarOnMapEvent extends MapEvent {
  const SetCarOnMapEvent({required this.carOnMap});

  final CarOnMap carOnMap;
}

class SetPresentPlaceMarks extends MapEvent {
  const SetPresentPlaceMarks({this.zoom, this.point, this.forceSet = false});

  final double? zoom;
  final Point? point;
  final bool forceSet;
}
