part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.userLocationAccessingStatus = FormzSubmissionStatus.initial,
    this.userCurrentLat = 0,
    this.userCurrentLong = 0,
    this.next = '',
    this.locationSettingsTriggered = false,
    this.drawnMapObjects,
    this.userLocationObject,
    this.zoomLevel = 15,
    this.locationAccessStatus = LocationPermissionStatus.permissionGranted,
    this.hasLuminosity = false,
    this.isMapInitialized = false,
    this.cameraPosition,
    this.drawingObjects = false,
    this.clusters = const [],
  });

  final FormzSubmissionStatus userLocationAccessingStatus;
  final LocationPermissionStatus locationAccessStatus;
  final List<MapObject>? drawnMapObjects;
  final List<ClusterEntity> clusters;
  final MapObject? userLocationObject;
  final double userCurrentLat;
  final double userCurrentLong;
  final Point? cameraPosition;
  final double zoomLevel;
  final String next;
  final bool locationSettingsTriggered;
  final bool hasLuminosity;
  final bool isMapInitialized;
  final bool drawingObjects;

  MapState copyWith({
    FormzSubmissionStatus? userLocationAccessingStatus,
    double? userCurrentLat,
    double? userCurrentLong,
    String? next,
    bool? locationSettingsTriggered,
    List<MapObject>? drawnMapObjects,
    MapObject? userLocationObject,
    double? zoomLevel,
    LocationPermissionStatus? locationAccessStatus,
    bool? hasLuminosity,
    bool? isMapInitialized,
    Point? cameraPosition,
    bool? drawingObjects,
    List<ClusterEntity>? clusters,
  }) {
    return MapState(
      userCurrentLat: userCurrentLat ?? this.userCurrentLat,
      userCurrentLong: userCurrentLong ?? this.userCurrentLong,
      next: next ?? this.next,
      locationSettingsTriggered: locationSettingsTriggered ?? this.locationSettingsTriggered,
      locationAccessStatus: locationAccessStatus ?? this.locationAccessStatus,
      drawnMapObjects: drawnMapObjects ?? this.drawnMapObjects,
      userLocationObject: userLocationObject ?? this.userLocationObject,
      userLocationAccessingStatus: userLocationAccessingStatus ?? this.userLocationAccessingStatus,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      hasLuminosity: hasLuminosity ?? this.hasLuminosity,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      drawingObjects: drawingObjects ?? this.drawingObjects,
      clusters: clusters ?? this.clusters,
    );
  }

  @override
  List<Object?> get props => [
        userLocationAccessingStatus,
        locationAccessStatus,
        drawnMapObjects,
        userLocationObject,
        userCurrentLat,
        userCurrentLong,
        cameraPosition,
        zoomLevel,
        next,
        locationSettingsTriggered,
        hasLuminosity,
        isMapInitialized,
        drawingObjects,
        clusters,
      ];
}
