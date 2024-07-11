part of 'charge_locations_bloc.dart';

class ChargeLocationsState extends Equatable {
  final List<ChargeLocationEntity> chargeLocations;
  final FormzSubmissionStatus getChargeLocationsStatus;
  final ChargeLocationEntity singleChargeLocation;
  final FormzSubmissionStatus getSingleChargeLocationStatus;
  final String next;
  final bool fetchMore;
  final String searchPattern;
  final List<int> selectedPowerTypes;
  final List<int> selectedConnectorTypes;
  final List<IdNameEntity> selectedVendors;
  final List<String> selectedStatuses;
  final bool integrated;
  final double zoom;
  final int radius;
  final double latitude;
  final double longitude;
  final bool isFavourite;
  final bool isForMap;

  const ChargeLocationsState({
    this.chargeLocations = const [],
    this.getChargeLocationsStatus = FormzSubmissionStatus.initial,
    this.singleChargeLocation = const ChargeLocationEntity(),
    this.getSingleChargeLocationStatus = FormzSubmissionStatus.initial,
    this.next = '',
    this.fetchMore = false,
    this.searchPattern = '',
    this.selectedConnectorTypes = const [],
    this.selectedPowerTypes = const [],
    this.zoom = -1,
    this.latitude = -1,
    this.longitude = -1,
    this.isFavourite = false,
    this.selectedVendors = const [],
    this.selectedStatuses = const [],
    this.integrated = false,
    this.radius = -1,
    required this.isForMap,
  });

  ChargeLocationsState copyWith({
    List<ChargeLocationEntity>? chargeLocations,
    FormzSubmissionStatus? getChargeLocationsStatus,
    ChargeLocationEntity? singleChargeLocation,
    FormzSubmissionStatus? getSingleChargeLocationStatus,
    String? next,
    bool? fetchMore,
    String? searchPattern,
    List<int>? selectedPowerTypes,
    List<int>? selectedConnectorTypes,
    List<IdNameEntity>? selectedVendors,
    List<String>? selectedStatuses,
    bool? integrated,
    double? zoom,
    double? latitude,
    double? longitude,
    bool? isFavourite,
    int? radius,
  }) {
    return ChargeLocationsState(
      chargeLocations: chargeLocations ?? this.chargeLocations,
      getChargeLocationsStatus: getChargeLocationsStatus ?? this.getChargeLocationsStatus,
      singleChargeLocation: singleChargeLocation ?? this.singleChargeLocation,
      getSingleChargeLocationStatus: getSingleChargeLocationStatus ?? this.getSingleChargeLocationStatus,
      next: next ?? this.next,
      fetchMore: fetchMore ?? this.fetchMore,
      searchPattern: searchPattern ?? this.searchPattern,
      selectedPowerTypes: selectedPowerTypes ?? this.selectedPowerTypes,
      selectedConnectorTypes: selectedConnectorTypes ?? this.selectedConnectorTypes,
      selectedVendors: selectedVendors ?? this.selectedVendors,
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
      integrated: integrated ?? this.integrated,
      zoom: zoom ?? this.zoom,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavourite: isFavourite ?? this.isFavourite,
      radius: radius ?? this.radius,
      isForMap: isForMap,
    );
  }

  @override
  List<Object?> get props => [
        chargeLocations,
        getSingleChargeLocationStatus,
        getChargeLocationsStatus,
        fetchMore,
        next,
        singleChargeLocation,
        searchPattern,
        selectedConnectorTypes,
        selectedPowerTypes,
        selectedVendors,
        zoom,
        latitude,
        longitude,
        isFavourite,
        radius,
        isForMap,
        integrated,
        selectedStatuses,
      ];
}
