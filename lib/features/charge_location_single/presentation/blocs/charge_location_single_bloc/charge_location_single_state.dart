part of 'charge_location_single_bloc.dart';

class ChargeLocationSingleState extends Equatable {
  const ChargeLocationSingleState({
    this.getSingleStatus = FormzSubmissionStatus.initial,
    this.location = const ChargeLocationSingleEntity(),
    this.errorMessage = '',
    this.allConnectors = const [],
    this.selectedStationIndex = 0,
    this.isNearToStation = true,
  });

  final FormzSubmissionStatus getSingleStatus;
  final ChargeLocationSingleEntity location;
  final String errorMessage;
  final List<ConnectorEntity> allConnectors;
  final int selectedStationIndex;
  final bool isNearToStation;

  ChargeLocationSingleState copyWith({
    FormzSubmissionStatus? getSingleStatus,
    ChargeLocationSingleEntity? location,
    String? errorMessage,
    List<ConnectorEntity>? allConnectors,
    int? selectedStationIndex,
    bool? isNearToStation,
  }) {
    return ChargeLocationSingleState(
      getSingleStatus: getSingleStatus ?? this.getSingleStatus,
      location: location ?? this.location,
      errorMessage: errorMessage ?? this.errorMessage,
      allConnectors: allConnectors ?? this.allConnectors,
      selectedStationIndex: selectedStationIndex ?? this.selectedStationIndex,
      isNearToStation: isNearToStation ?? this.isNearToStation,
    );
  }

  @override
  List<Object> get props => [
        getSingleStatus,
        location,
        errorMessage,
        allConnectors,
        selectedStationIndex,
        isNearToStation,
      ];
}
