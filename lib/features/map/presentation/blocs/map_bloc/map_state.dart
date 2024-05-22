part of 'map_bloc.dart';

class MapState extends Equatable {
  final FormzSubmissionStatus userLocationAccessingStatus;
  final LocationPermissionStatus locationAccessStatus;
  final int count;
  final ClusterizedPlacemarkCollection? locationsMapObjects;
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
  final List<ChargeLocationEntity> chargeLocations;
  final ChargeLocationEntity selectedChargeLocation;

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
    List<ChargeLocationEntity>? chargeLocations,
    ChargeLocationEntity? selectedChargeLocation,
  }) {
    return MapState(
      count: count ?? this.count,
      currentLat: currentLat ?? this.currentLat,
      currentLong: currentLong ?? this.currentLong,
      next: next ?? this.next,
      locationSettingsTriggered: locationSettingsTriggered ?? this.locationSettingsTriggered,
      locationAccessStatus: locationAccessStatus ?? this.locationAccessStatus,
      locationsMapObjects: chargeLocationsObjects ?? this.locationsMapObjects,
      userLocationObject: userLocationObject ?? this.userLocationObject,
      userLocationAccessingStatus: userLocationAccessingStatus ?? this.userLocationAccessingStatus,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      hasLuminosity: hasLuminosity ?? this.hasLuminosity,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      areControllersVisible: areControllersVisible ?? this.areControllersVisible,
      isSearchFieldVisible: isSearchFieldVisible ?? this.isSearchFieldVisible,
      isMapTappedAlready: isMapTappedAlready ?? this.isMapTappedAlready,
      chargeLocations: chargeLocations ?? this.chargeLocations,
      selectedChargeLocation: selectedChargeLocation ?? this.selectedChargeLocation,
    );
  }

  const MapState({
    this.userLocationAccessingStatus = FormzSubmissionStatus.initial,
    this.count = 0,
    this.currentLat = 0,
    this.currentLong = 0,
    this.next = '',
    this.locationSettingsTriggered = false,
    this.locationsMapObjects,
    this.userLocationObject,
    this.zoomLevel = 15,
    this.locationAccessStatus = LocationPermissionStatus.permissionGranted,
    this.hasLuminosity = false,
    this.isMapInitialized = false,
    this.areControllersVisible = false,
    this.isSearchFieldVisible = false,
    this.isMapTappedAlready = false,
    this.chargeLocations = const [],
    this.selectedChargeLocation = const ChargeLocationEntity(),
  });

  @override
  List<Object?> get props => [
        userLocationAccessingStatus,
        count,
        currentLat,
        currentLong,
        next,
        locationsMapObjects,
        userLocationObject,
        zoomLevel,
        locationAccessStatus,
        locationSettingsTriggered,
        hasLuminosity,
        isMapInitialized,
        areControllersVisible,
        isSearchFieldVisible,
        isMapTappedAlready,
      ];
}
