import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_features_usecase.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_usecase.dart';

part 'version_check_event.dart';
part 'version_check_state.dart';

class VersionCheckBloc extends Bloc<VersionCheckEvent, VersionCheckState> {
  final GetAppLatestVersionUseCase _getAppLatestVersionUseCase;
  final GetVersionFeaturesUseCase _getVersionFeaturesUseCase;

  VersionCheckBloc(
    this._getAppLatestVersionUseCase,
    this._getVersionFeaturesUseCase,
  ) : super(const VersionCheckState()) {
    on<GetVersionEvent>((event, emit) async {
      emit(state.copyWith(getVersionStatus: FormzSubmissionStatus.inProgress));
      final result = await _getAppLatestVersionUseCase.call(NoParams());
      if (result.isRight) {
        late final String version;
        late final bool isRequired;
        version = result.right.number;
        isRequired = result.right.isForceUpdate;
        final needToUpdate = await MyFunctions.needToUpdate(version);

        if (!needToUpdate) {
          List<String> data = StorageRepository.getList(StorageKeys.versionFeatures);
          if (!data.contains(version)) {
            add(GetVersionFeaturesEvent(result.right.id));
          }
        }

        emit(state.copyWith(
          getVersionStatus: FormzSubmissionStatus.success,
          isRequired: isRequired,
          version: version,
        ));
      } else {
        emit(state.copyWith(getVersionStatus: FormzSubmissionStatus.failure));
      }
    });
    on<GetVersionFeaturesEvent>((event, emit) async {
      emit(state.copyWith(getVersionFeaturesStatus: FormzSubmissionStatus.inProgress));
      final result = await _getVersionFeaturesUseCase.call(event.versionId);
      if (result.isRight) {
        emit(state.copyWith(
          getVersionFeaturesStatus: FormzSubmissionStatus.success,
          versionFeatures: result.right.results,
        ));
      } else if (result.isLeft) {
        emit(state.copyWith(getVersionFeaturesStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
