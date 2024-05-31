part of 'charge_location_single_bloc.dart';

class ChargeLocationSingleState extends Equatable {
  const ChargeLocationSingleState({
    this.getSingleStatus = FormzSubmissionStatus.initial,
    this.location = const ChargeLocationSingleEntity(),
    this.errorMessage = '',
    this.allConnectors = const [],
  });

  final FormzSubmissionStatus getSingleStatus;
  final ChargeLocationSingleEntity location;
  final String errorMessage;
  final List<ConnectorEntity> allConnectors;

  ChargeLocationSingleState copyWith({
    FormzSubmissionStatus? getSingleStatus,
    ChargeLocationSingleEntity? location,
    String? errorMessage,
    List<ConnectorEntity>? allConnectors,
  }) {
    return ChargeLocationSingleState(
      getSingleStatus: getSingleStatus ?? this.getSingleStatus,
      location: location ?? this.location,
      errorMessage: errorMessage ?? this.errorMessage,
      allConnectors: allConnectors ?? this.allConnectors,
    );
  }

  @override
  List<Object> get props => [
        getSingleStatus,
        location,
        errorMessage,
        allConnectors,
      ];
}
