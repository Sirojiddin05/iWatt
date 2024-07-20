import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/network/dio_settings.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/common/domain/usecases/change_language_usecase.dart';
import 'package:i_watt_app/service_locator.dart';

part 'change_language_event.dart';
part 'change_language_state.dart';

class ChangeLanguageBloc extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  final ChangeLanguageUseCase changeLanguageUseCase;
  ChangeLanguageBloc(this.changeLanguageUseCase) : super(const ChangeLanguageState()) {
    on<ChangeLanguage>((event, emit) async {
      emit(state.copyWith(changeLanguageStatus: FormzSubmissionStatus.inProgress));
      await StorageRepository.putString(StorageKeys.previousLanguage, event.context.locale.languageCode);
      await StorageRepository.putString(StorageKeys.currentLanguage, event.languageCode);
      await event.context.setLocale(Locale(event.languageCode));
      serviceLocator<DioSettings>().setBaseOptions();
      await resetLocator();
      emit(state.copyWith(changeLanguageStatus: FormzSubmissionStatus.success));
      await changeLanguageUseCase(event.languageCode);
      // if (result.isRight) {
      //   emit(state.copyWith(changeLanguageStatus: FormzSubmissionStatus.success));
      // } else {
      //   emit(state.copyWith(changeLanguageStatus: FormzSubmissionStatus.failure));
      // }
    });
  }
}
