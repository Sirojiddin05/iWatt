part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.userLocationAccessingStatus = FormzSubmissionStatus.initial,
    this.count = 0,
    this.currentLat = 0,
    this.currentLong = 0,
    this.next = '',
    this.locationSettingsTriggered = false,
    this.drawnMapObjects,
    this.presentedObjects,
    this.userLocationObject,
    this.zoomLevel = 15,
    this.locationAccessStatus = LocationPermissionStatus.permissionGranted,
    this.hasLuminosity = false,
    this.isMapInitialized = false,
    this.chargeLocations = const [],
    this.selectedLocation = const ChargeLocationEntity(),
  });

  final FormzSubmissionStatus userLocationAccessingStatus;
  final LocationPermissionStatus locationAccessStatus;
  final int count;
  final List<PlacemarkMapObject>? drawnMapObjects;
  final ClusterizedPlacemarkCollection? presentedObjects;
  final MapObject? userLocationObject;
  final double currentLat;
  final double currentLong;
  final double zoomLevel;
  final String next;
  final bool locationSettingsTriggered;
  final bool hasLuminosity;
  final bool isMapInitialized;
  final List<ChargeLocationEntity> chargeLocations;
  final ChargeLocationEntity selectedLocation;

  MapState copyWith({
    FormzSubmissionStatus? userLocationAccessingStatus,
    int? count,
    double? currentLat,
    double? currentLong,
    String? next,
    bool? locationSettingsTriggered,
    List<PlacemarkMapObject>? drawnMapObjects,
    ClusterizedPlacemarkCollection? presentedObjects,
    MapObject? userLocationObject,
    double? zoomLevel,
    LocationPermissionStatus? locationAccessStatus,
    bool? hasLuminosity,
    bool? isMapInitialized,
    List<ChargeLocationEntity>? chargeLocations,
    ChargeLocationEntity? selectedLocation,
  }) {
    return MapState(
      count: count ?? this.count,
      currentLat: currentLat ?? this.currentLat,
      currentLong: currentLong ?? this.currentLong,
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
      chargeLocations: chargeLocations ?? this.chargeLocations,
      selectedLocation: selectedLocation ?? this.selectedLocation,
    );
  }

  @override
  List<Object?> get props => [
        userLocationAccessingStatus,
        locationAccessStatus,
        count,
        drawnMapObjects,
        userLocationObject,
        currentLat,
        currentLong,
        zoomLevel,
        next,
        locationSettingsTriggered,
        hasLuminosity,
        isMapInitialized,
        chargeLocations,
        selectedLocation,
        drawnMapObjects,
        presentedObjects,
      ];
}
