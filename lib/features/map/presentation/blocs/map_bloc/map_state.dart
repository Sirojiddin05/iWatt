part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.userLocationAccessingStatus = FormzSubmissionStatus.initial,
    this.userCurrentLat = 0,
    this.userCurrentLong = 0,
    this.next = '',
    this.locationSettingsTriggered = false,
    this.presentedMapObjects = const [],
    this.userLocationObject,
    this.zoomLevel = 15,
    this.locationAccessStatus = LocationPermissionStatus.permissionGranted,
    this.hasLuminosity = false,
    this.isMapInitialized = false,
    this.drawingObjects = false,
    this.locations = const [],
    this.filteredLocations = const [],
    this.cameraPosition = const LatLng(0, 0),
    this.drawnMapObjects = const [],
    this.locationSingleOpened = false,
  });

  final FormzSubmissionStatus userLocationAccessingStatus;
  final LocationPermissionStatus locationAccessStatus;
  final List<Marker> presentedMapObjects;
  final List<Marker> drawnMapObjects;
  final List<ChargeLocationEntity> locations;
  final List<ChargeLocationEntity> filteredLocations;
  final Marker? userLocationObject;
  final double userCurrentLat;
  final double userCurrentLong;
  final double zoomLevel;
  final String next;
  final bool locationSettingsTriggered;
  final bool hasLuminosity;
  final bool isMapInitialized;
  final bool drawingObjects;
  final LatLng cameraPosition;
  final bool locationSingleOpened;

  MapState copyWith({
    FormzSubmissionStatus? userLocationAccessingStatus,
    double? userCurrentLat,
    double? userCurrentLong,
    String? next,
    bool? locationSettingsTriggered,
    List<Marker>? presentedMapObjects,
    List<Marker>? drawnMapObjects,
    Marker? userLocationObject,
    double? zoomLevel,
    LocationPermissionStatus? locationAccessStatus,
    bool? hasLuminosity,
    bool? isMapInitialized,
    LatLng? cameraPosition,
    bool? drawingObjects,
    List<ClusterEntity>? clusters,
    List<ChargeLocationEntity>? locations,
    List<ChargeLocationEntity>? filteredLocations,
    bool? locationSingleOpened,
  }) {
    return MapState(
      userCurrentLat: userCurrentLat ?? this.userCurrentLat,
      userCurrentLong: userCurrentLong ?? this.userCurrentLong,
      next: next ?? this.next,
      locationSettingsTriggered: locationSettingsTriggered ?? this.locationSettingsTriggered,
      locationAccessStatus: locationAccessStatus ?? this.locationAccessStatus,
      presentedMapObjects: presentedMapObjects ?? this.presentedMapObjects,
      userLocationObject: userLocationObject ?? this.userLocationObject,
      userLocationAccessingStatus: userLocationAccessingStatus ?? this.userLocationAccessingStatus,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      hasLuminosity: hasLuminosity ?? this.hasLuminosity,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      drawingObjects: drawingObjects ?? this.drawingObjects,
      locations: locations ?? this.locations,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      filteredLocations: filteredLocations ?? this.filteredLocations,
      drawnMapObjects: drawnMapObjects ?? this.drawnMapObjects,
      locationSingleOpened: locationSingleOpened ?? this.locationSingleOpened,
    );
  }

  @override
  List<Object?> get props => [
        userLocationAccessingStatus,
        locationAccessStatus,
        presentedMapObjects,
        userLocationObject,
        userCurrentLat,
        userCurrentLong,
        zoomLevel,
        next,
        locationSettingsTriggered,
        hasLuminosity,
        isMapInitialized,
        drawingObjects,
        locations,
        cameraPosition,
        filteredLocations,
        drawnMapObjects,
        locations,
        locationSingleOpened,
      ];
}
