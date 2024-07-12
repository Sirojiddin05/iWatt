part of 'map_locations_bloc.dart';

@immutable
abstract class MapLocationsEvent {
  const MapLocationsEvent();
}

class GeAllLocationsFromRemoteEvent extends MapLocationsEvent {
  const GeAllLocationsFromRemoteEvent();
}

class GetLocationsFromLocal extends MapLocationsEvent {}

class SetVisibleRegionBounds extends MapLocationsEvent {
  const SetVisibleRegionBounds({required this.bounds});

  final LatLngBounds bounds;
}

class SetFilterForMapLocationsEvent extends MapLocationsEvent {
  final List<int> connectorTypes;
  final List<int> powerTypes;
  final List<IdNameEntity> vendors;
  final List<String> locationStatuses;
  final bool integrated;

  const SetFilterForMapLocationsEvent({
    required this.connectorTypes,
    required this.powerTypes,
    required this.vendors,
    required this.locationStatuses,
    required this.integrated,
  });
}

class GetFilteredLocations extends MapLocationsEvent {
  const GetFilteredLocations();
}
