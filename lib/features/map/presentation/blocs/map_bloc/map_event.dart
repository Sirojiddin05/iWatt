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
  const DrawChargeLocationsEvent({required this.onLocationTap, this.withLuminosity = false});

  final ValueChanged<ChargeLocationEntity> onLocationTap;
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
  const SetPresentPlaceMarks({required this.zoom, required this.point});

  final double? zoom;
  final LatLng? point;
}

class ZoomInEvent extends MapEvent {
  const ZoomInEvent();
}

class ZoomOutEvent extends MapEvent {
  const ZoomOutEvent();
}

class GetAllLocationsEvent extends MapEvent {
  const GetAllLocationsEvent();
}
