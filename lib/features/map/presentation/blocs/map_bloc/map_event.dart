part of 'map_bloc.dart';

abstract class MapEvent {
  const MapEvent();
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

  final GoogleMapController mapController;
  final BuildContext context;
}

class DrawChargeLocationsEvent extends MapEvent {
  const DrawChargeLocationsEvent();
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
  const SetPresentPlaceMarks(this.locations);

  final List<ChargeLocationEntity> locations;
}

class ZoomInEvent extends MapEvent {
  const ZoomInEvent();
}

class ZoomOutEvent extends MapEvent {
  const ZoomOutEvent();
}

class CameraMovedEvent extends MapEvent {
  const CameraMovedEvent({required this.cameraPosition});

  final CameraPosition cameraPosition;
}

class CameraIdled extends MapEvent {}

class SetMapStyleEvent extends MapEvent {
  const SetMapStyleEvent({required this.mapStyle});

  final String mapStyle;
}

class SetMarkersEvent extends MapEvent {
  const SetMarkersEvent({required this.markers});

  final Set<Marker> markers;
}

class SetLocationSingleOpened extends MapEvent {
  const SetLocationSingleOpened({required this.isOpened});

  final bool isOpened;
}

class SaveLocationListEvent extends MapEvent {
  const SaveLocationListEvent({required this.locations});

  final List<ChargeLocationEntity> locations;
}
