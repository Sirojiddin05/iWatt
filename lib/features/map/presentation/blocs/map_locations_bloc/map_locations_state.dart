part of 'map_locations_bloc.dart';

class MapLocationsState extends Equatable {
  const MapLocationsState({
    this.chargeLocations = const [],
    this.getChargeLocationsStatus = FormzSubmissionStatus.initial,
    this.getLocationsFromRemoteStatus = FormzSubmissionStatus.initial,
    this.selectedPowerTypes = const [],
    this.selectedConnectorTypes = const [],
    this.selectedVendors = const [],
    this.selectedStatuses = const [],
    this.integrated = false,
    this.northEastLatitude = -1,
    this.northEastLongitude = -1,
    this.southWestLatitude = -1,
    this.southWestLongitude = -1,
    this.cameraPosition,
    this.filteredLocationIds = const [],
  });

  final List<ChargeLocationEntity> chargeLocations;
  final FormzSubmissionStatus getChargeLocationsStatus;
  final FormzSubmissionStatus getLocationsFromRemoteStatus;
  final List<int> selectedPowerTypes;
  final List<int> selectedConnectorTypes;
  final List<IdNameEntity> selectedVendors;
  final List<String> selectedStatuses;
  final bool integrated;
  final double northEastLatitude;
  final double northEastLongitude;
  final double southWestLatitude;
  final double southWestLongitude;
  final CameraPosition? cameraPosition;
  final List<int> filteredLocationIds;

  MapLocationsState copyWith({
    List<ChargeLocationEntity>? chargeLocations,
    FormzSubmissionStatus? getChargeLocationsStatus,
    FormzSubmissionStatus? getLocationsFromRemoteStatus,
    List<int>? selectedPowerTypes,
    List<int>? selectedConnectorTypes,
    List<IdNameEntity>? selectedVendors,
    List<String>? selectedStatuses,
    bool? integrated,
    double? northEastLatitude,
    double? northEastLongitude,
    double? southWestLatitude,
    double? southWestLongitude,
    CameraPosition? cameraPosition,
    List<int>? filteredLocationIds,
  }) {
    return MapLocationsState(
      chargeLocations: chargeLocations ?? this.chargeLocations,
      getChargeLocationsStatus: getChargeLocationsStatus ?? this.getChargeLocationsStatus,
      getLocationsFromRemoteStatus: getLocationsFromRemoteStatus ?? this.getLocationsFromRemoteStatus,
      selectedPowerTypes: selectedPowerTypes ?? this.selectedPowerTypes,
      selectedConnectorTypes: selectedConnectorTypes ?? this.selectedConnectorTypes,
      integrated: integrated ?? this.integrated,
      northEastLatitude: northEastLatitude ?? this.northEastLatitude,
      northEastLongitude: northEastLongitude ?? this.northEastLongitude,
      southWestLatitude: southWestLatitude ?? this.southWestLatitude,
      southWestLongitude: southWestLongitude ?? this.southWestLongitude,
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
      selectedVendors: selectedVendors ?? this.selectedVendors,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      filteredLocationIds: filteredLocationIds ?? this.filteredLocationIds,
    );
  }

  @override
  List<Object> get props => [
        chargeLocations,
        getChargeLocationsStatus,
        selectedPowerTypes,
        selectedConnectorTypes,
        selectedVendors,
        selectedStatuses,
        integrated,
        northEastLatitude,
        northEastLongitude,
        southWestLatitude,
        southWestLongitude,
        getChargeLocationsStatus,
        getLocationsFromRemoteStatus,
        filteredLocationIds
      ];
}
