part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.userLocationAccessingStatus = FormzSubmissionStatus.initial,
    this.userCurrentLat = 0,
    this.userCurrentLong = 0,
    this.locationSettingsTriggered = false,
    this.presentedMapObjects = const [],
    this.userLocationObject,
    this.locationAccessStatus = LocationPermissionStatus.permissionGranted,
    this.hasLuminosity = false,
    this.isMapInitialized = false,
    this.locationSingleOpened = false,
  });

  final FormzSubmissionStatus userLocationAccessingStatus;
  final LocationPermissionStatus locationAccessStatus;
  final List<Marker> presentedMapObjects;
  final Marker? userLocationObject;
  final double userCurrentLat;
  final double userCurrentLong;
  final bool locationSettingsTriggered;
  final bool hasLuminosity;
  final bool isMapInitialized;
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
    List<ClusterEntity>? clusters,
    List<ChargeLocationEntity>? locations,
    List<ChargeLocationEntity>? filteredLocations,
    bool? locationSingleOpened,
  }) {
    return MapState(
      userCurrentLat: userCurrentLat ?? this.userCurrentLat,
      userCurrentLong: userCurrentLong ?? this.userCurrentLong,
      locationSettingsTriggered: locationSettingsTriggered ?? this.locationSettingsTriggered,
      locationAccessStatus: locationAccessStatus ?? this.locationAccessStatus,
      presentedMapObjects: presentedMapObjects ?? this.presentedMapObjects,
      userLocationObject: userLocationObject ?? this.userLocationObject,
      userLocationAccessingStatus: userLocationAccessingStatus ?? this.userLocationAccessingStatus,
      hasLuminosity: hasLuminosity ?? this.hasLuminosity,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
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
        locationSettingsTriggered,
        hasLuminosity,
        isMapInitialized,
        locationSingleOpened,
      ];
}
