part of 'charging_process_bloc.dart';

class ChargingProcessState extends Equatable {
  final FormzSubmissionStatus startProcessStatus;
  final String startProcessErrorMessage;
  final FormzSubmissionStatus stopProcessStatus;
  final String stopProcessErrorMessage;

  final List<ChargingProcessEntity> processes;

  const ChargingProcessState({
    this.processes = const [],
    this.startProcessStatus = FormzSubmissionStatus.initial,
    this.stopProcessStatus = FormzSubmissionStatus.initial,
    this.startProcessErrorMessage = '',
    this.stopProcessErrorMessage = '',
  });

  ChargingProcessState copyWith({
    List<ChargingProcessEntity>? processes,
    FormzSubmissionStatus? startProcessStatus,
    FormzSubmissionStatus? stopProcessStatus,
    String? startProcessErrorMessage,
    String? stopProcessErrorMessage,
  }) {
    return ChargingProcessState(
      processes: processes ?? this.processes,
      startProcessStatus: startProcessStatus ?? this.startProcessStatus,
      stopProcessStatus: stopProcessStatus ?? this.stopProcessStatus,
      startProcessErrorMessage: startProcessErrorMessage ?? this.startProcessErrorMessage,
      stopProcessErrorMessage: stopProcessErrorMessage ?? this.stopProcessErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        startProcessStatus,
        startProcessErrorMessage,
        stopProcessStatus,
        stopProcessErrorMessage,
        processes,
      ];
}
