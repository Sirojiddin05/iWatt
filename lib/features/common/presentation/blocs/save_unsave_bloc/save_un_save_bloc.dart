import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unave_location_usecase.dart';

part 'save_un_save_event.dart';
part 'save_un_save_state.dart';

class SaveUnSaveBloc extends Bloc<SaveUnSaveEvent, SaveUnSaveState> {
  final SaveUnSaveChargeLocationUseCase saveChargeLocationUseCase;
  final ChargeLocationEntity location;
  SaveUnSaveBloc({required this.saveChargeLocationUseCase, required this.location}) : super(SaveUnSaveState(location: location)) {
    on<SaveEvent>((event, emit) async {
      final location = state.location;
      emit(
        SaveUnSaveState(
          location: location.copyWith(isFavorite: !location.isFavorite),
          status: FormzSubmissionStatus.inProgress,
        ),
      );
      final result = await saveChargeLocationUseCase(location);
      if (result.isRight) {
        emit(
          const SaveUnSaveState(status: FormzSubmissionStatus.success),
        );
      } else {
        emit(
          SaveUnSaveState(
            location: location.copyWith(isFavorite: location.isFavorite),
            status: FormzSubmissionStatus.success,
            error: result.left.errorMessage,
          ),
        );
      }
    });
  }
}
