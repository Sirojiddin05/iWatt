part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.userLocationAccessingStatus = FormzSubmissionStatus.initial,
    this.userCurrentLat = 0,
    this.userCurrentLong = 0,
    this.next = '',
    this.locationSettingsTriggered = false,
    this.drawnMapObjects,
    this.presentedObjects,
    this.userLocationObject,
    this.zoomLevel = 15,
    this.locationAccessStatus = LocationPermissionStatus.permissionGranted,
    this.hasLuminosity = false,
    this.isMapInitialized = false,
    this.allChargeLocations = const [],
    this.filteredChargeLocations = const [],
    this.cameraPosition,
    this.drawingObjects = false,
  });

  final FormzSubmissionStatus userLocationAccessingStatus;
  final LocationPermissionStatus locationAccessStatus;
  final List<PlacemarkMapObject>? drawnMapObjects;
  final ClusterizedPlacemarkCollection? presentedObjects;
  final MapObject? userLocationObject;
  final double userCurrentLat;
  final double userCurrentLong;
  final Point? cameraPosition;
  final double zoomLevel;
  final String next;
  final bool locationSettingsTriggered;
  final bool hasLuminosity;
  final bool isMapInitialized;
  final List<ChargeLocationEntity> allChargeLocations;
  final List<ChargeLocationEntity> filteredChargeLocations;
  final bool drawingObjects;

  MapState copyWith({
    FormzSubmissionStatus? userLocationAccessingStatus,
    double? userCurrentLat,
    double? userCurrentLong,
    String? next,
    bool? locationSettingsTriggered,
    List<PlacemarkMapObject>? drawnMapObjects,
    ClusterizedPlacemarkCollection? presentedObjects,
    MapObject? userLocationObject,
    double? zoomLevel,
    LocationPermissionStatus? locationAccessStatus,
    bool? hasLuminosity,
    bool? isMapInitialized,
    List<ChargeLocationEntity>? allChargeLocations,
    List<ChargeLocationEntity>? filteredChargeLocations,
    Point? cameraPosition,
    bool? drawingObjects,
  }) {
    return MapState(
      userCurrentLat: userCurrentLat ?? this.userCurrentLat,
      userCurrentLong: userCurrentLong ?? this.userCurrentLong,
      next: next ?? this.next,
      locationSettingsTriggered: locationSettingsTriggered ?? this.locationSettingsTriggered,
      locationAccessStatus: locationAccessStatus ?? this.locationAccessStatus,
      drawnMapObjects: drawnMapObjects ?? this.drawnMapObjects,
      presentedObjects: presentedObjects ?? this.presentedObjects,
      userLocationObject: userLocationObject ?? this.userLocationObject,
      userLocationAccessingStatus: userLocationAccessingStatus ?? this.userLocationAccessingStatus,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      hasLuminosity: hasLuminosity ?? this.hasLuminosity,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      allChargeLocations: allChargeLocations ?? this.allChargeLocations,
      filteredChargeLocations: filteredChargeLocations ?? this.filteredChargeLocations,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      drawingObjects: drawingObjects ?? this.drawingObjects,
    );
  }

  @override
  List<Object?> get props => [
        userLocationAccessingStatus,
        locationAccessStatus,
        drawnMapObjects,
        presentedObjects,
        userLocationObject,
        userCurrentLat,
        userCurrentLong,
        cameraPosition,
        zoomLevel,
        next,
        locationSettingsTriggered,
        hasLuminosity,
        isMapInitialized,
        allChargeLocations,
        filteredChargeLocations,
        drawingObjects
      ];
}
