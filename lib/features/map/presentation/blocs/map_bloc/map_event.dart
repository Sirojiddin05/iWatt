part of 'map_bloc.dart';

abstract class MapEvent {
  const MapEvent();
}

class SetChargeLocations extends MapEvent {
  final List<ChargeLocationEntity> locations;
  const SetChargeLocations(this.locations);
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
  const SetMyPositionEvent();
}

class InitializeMapControllerEvent extends MapEvent {
  final YandexMapController mapController;
  final BuildContext context;

  const InitializeMapControllerEvent({required this.mapController, required this.context});
}

class ChangeZoomEvent extends MapEvent {
  final CameraUpdate cameraUpdate;

  const ChangeZoomEvent(this.cameraUpdate);
}

class SaveZoomOnCameraPositionChanged extends MapEvent {
  final double zoom;

  const SaveZoomOnCameraPositionChanged(this.zoom);
}

class DrawChargeLocationsEvent extends MapEvent {
  final List<ChargeLocationEntity> locations;
  final ValueChanged<ChargeLocationEntity> onLocationTap;
  final bool withLuminosity;

  const DrawChargeLocationsEvent(this.locations, {required this.onLocationTap, this.withLuminosity = false});
}

class SelectChargeLocationEvent extends MapEvent {
  final ChargeLocationEntity location;

  const SelectChargeLocationEvent({required this.location});
}

class CheckIfSettingsTriggered extends MapEvent {}

class TapMapObjectEvent extends MapEvent {
  final PlacemarkMapObject object;
  final List<ConnectorStatus> connectorStatuses;

  const TapMapObjectEvent({required this.object, required this.connectorStatuses});
}

class ChangeLuminosityStateEvent extends MapEvent {
  final bool hasLuminosity;

  const ChangeLuminosityStateEvent({required this.hasLuminosity});
}

class SetControllersVisibilityEvent extends MapEvent {
  final bool? areControllersVisible;
  final bool? searchFieldVisible;

  const SetControllersVisibilityEvent({this.areControllersVisible, this.searchFieldVisible});
}

class SetDraggableSheetOffsetEvent extends MapEvent {
  final double offset;

  const SetDraggableSheetOffsetEvent(this.offset);
}
