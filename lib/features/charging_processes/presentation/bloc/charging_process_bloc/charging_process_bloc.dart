import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/charging_process_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/start_process_param_entity.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/start_charging_process_usecase.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/stop_charging_process_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';
import 'package:i_watt_app/features/common/domain/usecases/meter_value_stream_usecase.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

part 'charging_process_event.dart';
part 'charging_process_state.dart';

class ChargingProcessBloc extends Bloc<ChargingProcessEvent, ChargingProcessState> {
  final MeterValueStreamUseCase meterValueStreamUseCase;
  final StartChargingProcessUseCase startChargingProcessUseCase;
  final StopChargingProcessUseCase stopChargingProcessUseCase;
  late final StreamSubscription<MeterValueMessageEntity> meterValueStreamSubscription;
  ChargingProcessBloc({required this.startChargingProcessUseCase, required this.stopChargingProcessUseCase, required this.meterValueStreamUseCase})
      : super(const ChargingProcessState()) {
    meterValueStreamSubscription = meterValueStreamUseCase(NoParams()).listen((event) {
      add(UpdateMeterValueOfProcess(event));
    });
    on<CreateChargingProcessEvent>((event, emit) {
      final list = [...state.processes];
      list.add(ChargingProcessEntity().copyWith(connectorId: event.connector));
      emit(state.copyWith(processes: [...list]));
      add(StartChargingProcessEvent(connectionId: event.connector));
    });
    on<StartChargingProcessEvent>(_onStartChargingProcessEvent);
    on<UpdateMeterValueOfProcess>(_updateMeterValueOfProcess);
    on<StopChargingProcessEvent>(_onStopChargingProcessEvent);
    on<DeleteChargingProcessEvent>(_onDeleteChargingProcessEvent);
  }

  void _onStartChargingProcessEvent(StartChargingProcessEvent event, Emitter<ChargingProcessState> emit) async {
    emit(state.copyWith(startProcessStatus: FormzSubmissionStatus.inProgress));
    final result = await startChargingProcessUseCase(StartProcessParamEntity(connectionId: event.connectionId));
    if (result.isRight && result.right.isDelivered) {
      final list = [...state.processes];
      list.last = list.last.copyWith(startCommandId: result.right.id);
      emit(state.copyWith(
        processes: [...list],
        startProcessStatus: FormzSubmissionStatus.success,
      ));
    } else {
      emit(
        state.copyWith(
          startProcessStatus: FormzSubmissionStatus.failure,
          startProcessErrorMessage: '${LocaleKeys.did_not_manage_to_do_your_request.tr()} ${LocaleKeys.try_again.tr()}',
        ),
      );
      add(DeleteChargingProcessEvent(state.processes.length - 1));
    }
  }

  void _updateMeterValueOfProcess(UpdateMeterValueOfProcess event, Emitter<ChargingProcessState> emit) {
    final list = [...state.processes];
    for (int i = 0; i < list.length; i++) {
      if (list[i].startCommandId == event.meterValue.startCommandId) {
        list[i] = list[i].copyWith(meterValueMessage: event.meterValue);
        emit(state.copyWith(processes: [...list]));
        break;
      }
    }
  }

  void _onStopChargingProcessEvent(StopChargingProcessEvent event, Emitter<ChargingProcessState> emit) async {
    emit(state.copyWith(stopProcessStatus: FormzSubmissionStatus.inProgress));
    final result = await stopChargingProcessUseCase(event.transactionId);
    if (result.isRight) {
      final list = [...state.processes];
      list.last = list.last.copyWith(startCommandId: result.right.id);
      emit(state.copyWith(
        processes: [...list],
        stopProcessStatus: FormzSubmissionStatus.success,
      ));
    } else {
      emit(
        state.copyWith(
          stopProcessStatus: FormzSubmissionStatus.failure,
          stopProcessErrorMessage: LocaleKeys.did_not_manage_to_do_your_request.tr() + LocaleKeys.try_again.tr(),
        ),
      );
    }
  }

  void _onDeleteChargingProcessEvent(DeleteChargingProcessEvent event, Emitter<ChargingProcessState> emit) async {
    final list = [...state.processes];
    list.removeAt(event.index);
    emit(state.copyWith(processes: [...list]));
  }
}
