part of 'charge_location_single_bloc.dart';

class ChargeLocationSingleState extends Equatable {
  const ChargeLocationSingleState({
    this.getSingleStatus = FormzSubmissionStatus.initial,
    this.location = const ChargeLocationEntity(),
    this.errorMessage = '',
  });

  final FormzSubmissionStatus getSingleStatus;
  final ChargeLocationEntity location;
  final String errorMessage;

  ChargeLocationSingleState copyWith({
    FormzSubmissionStatus? getSingleStatus,
    ChargeLocationEntity? location,
    String? errorMessage,
  }) {
    return ChargeLocationSingleState(
      getSingleStatus: getSingleStatus ?? this.getSingleStatus,
      location: location ?? this.location,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [getSingleStatus, location, errorMessage];
}
