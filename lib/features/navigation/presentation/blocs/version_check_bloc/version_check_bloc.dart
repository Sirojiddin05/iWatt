import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_usecase.dart';

part 'version_check_event.dart';
part 'version_check_state.dart';

class VersionCheckBloc extends Bloc<VersionCheckEvent, VersionCheckState> {
  final GetAppLatestVersionUseCase _getAppLatestVersionUseCase;
  VersionCheckBloc(this._getAppLatestVersionUseCase) : super(const VersionCheckState()) {
    on<GetVersionEvent>((event, emit) async {
      emit(state.copyWith(getVersionStatus: FormzSubmissionStatus.inProgress));
      final result = await _getAppLatestVersionUseCase.call(NoParams());
      if (result.isRight) {
        late final String version;
        late final bool isRequired;
        if (Platform.isIOS) {
          version = result.right.iosVersion;
          isRequired = result.right.iosRequired;
        } else {
          version = result.right.androidVersion;
          isRequired = result.right.androidRequired;
        }
        final needToUpdate = await MyFunctions.needToUpdate(version);
        emit(
          state.copyWith(
            getVersionStatus: FormzSubmissionStatus.success,
            isRequired: isRequired,
            version: version,
            needToUpdate: needToUpdate,
          ),
        );
      } else {
        emit(state.copyWith(
          getVersionStatus: FormzSubmissionStatus.failure,
          needToUpdate: false,
        ));
      }
    });
  }
}
