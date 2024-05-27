part of 'save_un_save_bloc.dart';

class SaveUnSaveState extends Equatable {
  const SaveUnSaveState({
    this.location = const ChargeLocationEntity(),
    this.status = FormzSubmissionStatus.initial,
    this.error = '',
  });

  final ChargeLocationEntity location;
  final FormzSubmissionStatus status;
  final String error;

  SaveUnSaveState copyWith({
    ChargeLocationEntity? location,
    FormzSubmissionStatus? status,
    String? error,
  }) {
    return SaveUnSaveState(
      location: location ?? this.location,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [location, status, error];
}
