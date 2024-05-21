part of 'charge_location_single_bloc.dart';

class ChargeLocationSingleState extends Equatable {
  const ChargeLocationSingleState({
    this.getSingleStatus = FormzSubmissionStatus.initial,
  });

  final FormzSubmissionStatus getSingleStatus;

  ChargeLocationSingleState copyWith({
    FormzSubmissionStatus? getSingleStatus,
  }) {
    return ChargeLocationSingleState(
      getSingleStatus: getSingleStatus ?? this.getSingleStatus,
    );
  }

  @override
  List<Object> get props => [getSingleStatus];
}
