part of 'map_bloc.dart';

class MapState extends Equatable {
  final FormzSubmissionStatus userLocationAccessingStatus;
  final LocationPermissionStatus locationAccessStatus;
  final int count;
  final ClusterizedPlacemarkCollection? chargeLocationsObjects;
  final MapObject? userLocationObject;
  final double currentLat;
  final double currentLong;
  final double zoomLevel;
  final String next;
  final bool locationSettingsTriggered;
  final bool hasLuminosity;
  final bool isMapInitialized;
  final bool areControllersVisible;
  final bool isSearchFieldVisible;
  final bool isMapTappedAlready;
  final double draggableSheetOffset;

  MapState copyWith({
    FormzSubmissionStatus? userLocationAccessingStatus,
    int? count,
    double? currentLat,
    double? currentLong,
    String? next,
    bool? locationSettingsTriggered,
    ClusterizedPlacemarkCollection? chargeLocationsObjects,
    MapObject? userLocationObject,
    double? zoomLevel,
    LocationPermissionStatus? locationAccessStatus,
    bool? hasLuminosity,
    bool? isMapInitialized,
    bool? areControllersVisible,
    bool? isSearchFieldVisible,
    bool? isMapTappedAlready,
    double? draggableSheetOffset,
  }) {
    return MapState(
      count: count ?? this.count,
      currentLat: currentLat ?? this.currentLat,
      currentLong: currentLong ?? this.currentLong,
      next: next ?? this.next,
      locationSettingsTriggered: locationSettingsTriggered ?? this.locationSettingsTriggered,
      locationAccessStatus: locationAccessStatus ?? this.locationAccessStatus,
      chargeLocationsObjects: chargeLocationsObjects ?? this.chargeLocationsObjects,
      userLocationObject: userLocationObject ?? this.userLocationObject,
      userLocationAccessingStatus: userLocationAccessingStatus ?? this.userLocationAccessingStatus,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      hasLuminosity: hasLuminosity ?? this.hasLuminosity,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      areControllersVisible: areControllersVisible ?? this.areControllersVisible,
      isSearchFieldVisible: isSearchFieldVisible ?? this.isSearchFieldVisible,
      isMapTappedAlready: isMapTappedAlready ?? this.isMapTappedAlready,
      draggableSheetOffset: draggableSheetOffset ?? this.draggableSheetOffset,
    );
  }

  const MapState({
    this.userLocationAccessingStatus = FormzSubmissionStatus.initial,
    this.count = 0,
    this.currentLat = 0,
    this.currentLong = 0,
    this.next = '',
    this.locationSettingsTriggered = false,
    this.chargeLocationsObjects,
    this.userLocationObject,
    this.zoomLevel = 15,
    this.locationAccessStatus = LocationPermissionStatus.permissionGranted,
    this.hasLuminosity = false,
    this.isMapInitialized = false,
    this.areControllersVisible = false,
    this.isSearchFieldVisible = false,
    this.isMapTappedAlready = false,
    this.draggableSheetOffset = 77.1382857142857,
  });

  @override
  List<Object?> get props => [
        userLocationAccessingStatus,
        count,
        currentLat,
        currentLong,
        next,
        chargeLocationsObjects,
        userLocationObject,
        zoomLevel,
        locationAccessStatus,
        locationSettingsTriggered,
        hasLuminosity,
        isMapInitialized,
        areControllersVisible,
        isSearchFieldVisible,
        isMapTappedAlready,
        draggableSheetOffset,
      ];
}
