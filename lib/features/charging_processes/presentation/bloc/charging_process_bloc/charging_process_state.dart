part of 'charging_process_bloc.dart';

class ChargingProcessState extends Equatable {
  final FormzSubmissionStatus startProcessStatus;
  final String startProcessErrorMessage;
  final FormzSubmissionStatus stopProcessStatus;
  final FormzSubmissionStatus getChargingProcesses;
  final String getChargingProcessErrorMessage;
  final String stopProcessErrorMessage;
  final List<ChargingProcessEntity> processes;
  final TransactionMessageEntity transactionCheque;

  const ChargingProcessState({
    this.processes = const [],
    this.startProcessStatus = FormzSubmissionStatus.initial,
    this.stopProcessStatus = FormzSubmissionStatus.initial,
    this.startProcessErrorMessage = '',
    this.stopProcessErrorMessage = '',
    this.getChargingProcessErrorMessage = '',
    this.transactionCheque = const TransactionMessageEntity(),
    this.getChargingProcesses = FormzSubmissionStatus.initial,
  });

  ChargingProcessState copyWith({
    List<ChargingProcessEntity>? processes,
    FormzSubmissionStatus? startProcessStatus,
    FormzSubmissionStatus? stopProcessStatus,
    String? startProcessErrorMessage,
    String? stopProcessErrorMessage,
    String? getChargingProcessErrorMessage,
    TransactionMessageEntity? transactionCheque,
    FormzSubmissionStatus? getChargingProcesses,
  }) {
    return ChargingProcessState(
      processes: processes ?? this.processes,
      startProcessStatus: startProcessStatus ?? this.startProcessStatus,
      stopProcessStatus: stopProcessStatus ?? this.stopProcessStatus,
      startProcessErrorMessage: startProcessErrorMessage ?? this.startProcessErrorMessage,
      stopProcessErrorMessage: stopProcessErrorMessage ?? this.stopProcessErrorMessage,
      transactionCheque: transactionCheque ?? this.transactionCheque,
      getChargingProcesses: getChargingProcesses ?? this.getChargingProcesses,
      getChargingProcessErrorMessage: getChargingProcessErrorMessage ?? this.getChargingProcessErrorMessage,
    );
  }

  @override
  List<Object> get props => [
        startProcessStatus,
        startProcessErrorMessage,
        stopProcessStatus,
        getChargingProcesses,
        getChargingProcessErrorMessage,
        stopProcessErrorMessage,
        processes,
        transactionCheque,
      ];
}
